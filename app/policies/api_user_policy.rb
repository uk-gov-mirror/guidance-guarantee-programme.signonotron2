class ApiUserPolicy < BasePolicy
  def new?
    current_user.superadmin?
  end
  alias create? new?
  alias index? new?
  alias edit? new?
  alias update? new?
  alias revoke? new?
end
