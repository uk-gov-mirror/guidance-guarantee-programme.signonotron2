require_relative '../../app/models/enhancements/application'

class AddPhoneBookingPermission < ActiveRecord::Migration
  def change
    output = Doorkeeper::Application.find_by!(name: 'PW Summary Document Generator - TPAS')
    summary_document_generator = Doorkeeper::Application.find_by!(name: 'PW Summary Document Generator - CABs')

    say "Creating new 'phone_bookings' permission for output application"
    output_phone_bookings_permission = output.supported_permissions.find_or_create_by!(
      name: 'phone_bookings',
      delegatable: false,
      grantable_from_ui: true
    )

    say "Adding 'phone_bookings' permission for existing output users"
    users = output
              .supported_permissions
              .find_by(name: 'signin')
              .user_application_permissions
              .collect(&:user)

    users.each do |user|
      say "creating new permission for user: #{user.name}", true
      user.application_permissions.find_or_create_by!(
        application: output,
        supported_permission: output_phone_bookings_permission,
      )
    end

    say 'Adding signin permission for output to all users of old summary document generator'
    output_signin_permission = output.supported_permissions.find_by!(name: 'signin')

    users = summary_document_generator
              .supported_permissions
              .find_by(name: 'signin')
              .user_application_permissions
              .collect(&:user)

    users.each do |user|
      say "creating new permission for user: #{user.name}", true
      user.application_permissions.find_or_create_by!(
        application: output,
        supported_permission: output_signin_permission
      )
    end
  end
end
