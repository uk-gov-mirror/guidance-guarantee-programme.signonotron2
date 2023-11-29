class MigrateApplicationAndPermissionsToBatchInvitationApplicationPermissionsJoinTable < ActiveRecord::Migration
  def up # rubocop:disable Metrics/MethodLength
    puts "Updating #{BatchInvitation.count} batch invitations"

    BatchInvitation.all.each do |batch_invitation|
      supported_permissions = []
      batch_invitation.applications_and_permissions.each_value do |permission_attributes|
        application_id = permission_attributes['application_id']
        permissions = permission_attributes['permissions']
        if permissions.present?
          _supported_permissions << SupportedPermission.where(application_id: application_id,
                                                              name: permissions)
        end
      end
      batch_invitation.update(supported_permissions: _supported_permissions.flatten)
    end
    puts 'Done.'
  end
end
