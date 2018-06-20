require_relative '../../app/models/enhancements/application'

class AddDualPurposeGuiderPermissions < ActiveRecord::Migration
  APPLICATION = 'Summary Document Generator'.freeze
  PERMISSION  = 'face_to_face_bookings'.freeze

  def up
    if app = Doorkeeper::Application.find_by(name: APPLICATION)
      app.supported_permissions.find_or_create_by!(name: PERMISSION)

      User.with_access_to_application(app).not_suspended.find_each do |user|
        if user.permissions_for(app) == %w(signin)
          user.grant_application_permission(app, PERMISSION)

          say "Granted to #{user.name}."
        end
      end
    end
  end

  def down
    if app = Doorkeeper::Application.find_by(name: APPLICATION)
      app.supported_permissions.where(name: PERMISSION).destroy_all
      say "Removed the permission."
    end
  end
end
