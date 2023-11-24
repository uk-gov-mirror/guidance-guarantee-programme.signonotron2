class AddAdminSupportedPermissionToNeedoTron < ActiveRecord::Migration
  class SupportedPermission < ActiveRecord::Base
    belongs_to :application, class_name: 'Doorkeeper::Application'
  end

  def change
    needotron = ::Doorkeeper::Application.find_by_name('Need-o-Tron')
    SupportedPermission.create!(application: needotron, name: 'admin') if needotron
  end
end
