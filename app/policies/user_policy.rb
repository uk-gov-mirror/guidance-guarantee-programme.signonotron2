class UserPolicy < BasePolicy
  def new?
    # invitations#new
    current_user.superadmin? || current_user.admin? || current_user.organisation_admin?
  end
  alias index? new?

  def edit? # rubocop:disable Metrics/MethodLength
    case current_user.role
    when 'superadmin'
      true
    when 'admin'
      !record.superadmin?
    when 'organisation_admin'
      current_user.id == record.id ||
        (record.normal? && belong_to_same_organisation_subtree?(current_user, record))
    when 'normal'
      false
    end
  end
  alias create? edit? # invitations#create
  alias update? edit?
  alias unlock? edit?
  alias suspension? edit?
  alias resend? edit?

  def edit_email_or_passphrase?
    current_user.id == record.id
  end

  def update_passphrase?
    current_user.id == record.id
  end

  def cancel_email_change?
    (current_user.id == record.id) || edit?
  end

  def resend_email_change?
    (current_user.id == record.id) || edit?
  end

  def event_logs?
    current_user.normal? ? false : edit?
  end

  def assign_role?
    current_user.superadmin?
  end

  def flag_2sv?
    current_user.superadmin? || current_user.admin? || current_user.organisation_admin?
  end

  alias reset_2sv? flag_2sv?
  alias reset_two_step_verification? reset_2sv?

  class Scope < ::BasePolicy::Scope
    def resolve
      if current_user.superadmin?
        scope.web_users
      elsif current_user.admin?
        scope.web_users.where(role: %w[admin organisation_admin normal])
      elsif current_user.organisation_admin?
        scope.web_users
             .where(role: %w[organisation_admin normal])
             .where(organisation_id: current_user.organisation.subtree_ids)
      end
    end
  end
end
