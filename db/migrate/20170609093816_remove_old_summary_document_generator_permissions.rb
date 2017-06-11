require_relative '../../app/models/enhancements/application'

class RemoveOldSummaryDocumentGeneratorPermissions < ActiveRecord::Migration
  def change
    summary_document_generator = Doorkeeper::Application.find_by!(name: 'PW Summary Document Generator - CABs')

    say 'Removing signin permission to old summary document generator for all non admin users'
    user_application_permissions = summary_document_generator
              .supported_permissions
              .find_by(name: 'signin')
              .user_application_permissions

    user_application_permissions.each do |permission|
      user = permission.user
      admin_permission = user
                         .application_permissions
                         .joins(:supported_permission)
                         .where(
                           application: summary_document_generator,
                           supported_permissions: { name: 'pensionwise_admin' }
                         )

      if admin_permission.exists?
        say "user '#{user.name}' is an admin, leaving 'signin' permission in place", true
      else
        say "removing 'signin' permission for user '#{user.name}'", true
        permission.destroy
      end
    end
  end
end
