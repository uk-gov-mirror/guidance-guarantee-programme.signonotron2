class RemoveSupportAppErtpPermission < ActiveRecord::Migration
  class SupportedPermission < ActiveRecord::Base; end

  class Permission < ActiveRecord::Base
    serialize :permissions, Array
  end

  def up
    support = ::Doorkeeper::Application.find_by_name('Support')

    return if support.nil?

    permission = SupportedPermission.find_by_application_id_and_name(support.id, 'ertp')
    permission&.delete

    # remove user permissions
    all_support_perms = Permission.where(application_id: support.id)
    ertp_support_perms = all_support_perms.select { |perm| perm.permissions.include?('ertp') }
    ertp_support_perms.each do |perm|
      perm.permissions -= ['ertp']
      perm.save!
    end
  end
end
