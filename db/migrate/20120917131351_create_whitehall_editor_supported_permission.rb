class CreateWhitehallEditorSupportedPermission < ActiveRecord::Migration
  class SupportedPermission < ActiveRecord::Base
    belongs_to :application, class_name: 'Doorkeeper::Application'
  end

  class Permission < ActiveRecord::Base
    serialize :permissions, Array
  end

  def up
    whitehall = ::Doorkeeper::Application.find_by_name('Whitehall')
    return unless whitehall

    permission_name = 'Editor'
    permission = SupportedPermission.create!(application: whitehall, name: permission_name)
    Permission.where(application_id: whitehall.id).each do |individual_permission|
      if individual_permission.permissions.include?('signin')
        individual_permission.permissions << permission_name
        individual_permission.save!
      end
    end
  end
end
