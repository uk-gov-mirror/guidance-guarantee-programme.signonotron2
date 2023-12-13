class LicensingNewTestAuthorities < ActiveRecord::Migration
  def up
    return if licensing.nil?

    SupportedPermission.create(application: licensing, name: 'gds-test-2')
    SupportedPermission.create(application: licensing, name: 'gds-test-3')
  end

  def down
    return if licensing.nil?

    SupportedPermission.where(application_id: licensing.id, name: 'gds-test-2').delete_all
    SupportedPermission.create(application: licensing, name: 'gds-test-3').delete_all
  end

  def licensing
    @licensing ||= Doorkeeper::Application.find_by_name('Licensify')
  end
end
