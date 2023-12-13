class AddManageKeywordPermission < ActiveRecord::Migration
  def up
    SupportedPermission.create(application: panopticon, name: 'manage_keywords') unless panopticon.nil?
  end

  def down
    SupportedPermission.where(application_id: panopticon.id, name: 'manage_keywords').delete_all unless panopticon.nil?
  end

  def panopticon
    @panopticon ||= Doorkeeper::Application.find_by_name('Panopticon')
  end
end
