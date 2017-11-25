require 'enhancements/application'

class AddAgentPermissionToTeleperformanceUsers < ActiveRecord::Migration
  ORGANISATION_ID = 68 # Teleperformance
  PLANNER_ID      = 4 # Planner

  def up
    planner = Doorkeeper::Application.find(PLANNER_ID)

    User.where(organisation_id: ORGANISATION_ID).find_each do |user|
      user.grant_application_permission(planner, 'agent')
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
