require 'enhancements/application'

class GrantAcademyAccess < ActiveRecord::Migration
  ORGANISATION_IDS = [3, 4, 5] # CITA, CAS, NICAB

  def up
    academy = Doorkeeper::Application.find_by_name('Pension Wise Academy')

    if academy
      User.where(organisation_id: ORGANISATION_IDS).find_each do |user|
        user.grant_application_permission(academy, 'signin')
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
