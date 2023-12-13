class CreateUserManagersSupportAppPermission < ActiveRecord::Migration
  class SupportedPermission < ActiveRecord::Base
    belongs_to :application, class_name: 'Doorkeeper::Application'
  end

  def up
    support = ::Doorkeeper::Application.find_by_name('Support')
    SupportedPermission.create!(application: support, name: 'user_managers') if support
  end
end
