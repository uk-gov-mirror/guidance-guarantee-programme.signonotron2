class RootController < ApplicationController
  include UserPermissionsControllerMethods
  before_action :authenticate_user!
  skip_after_action :verify_authorized

  def index
    applications = (::Doorkeeper::Application.can_signin(current_user).to_a <<
                    ::Doorkeeper::Application.where(name: 'Support').first).compact.uniq

    @applications_and_permissions = zip_permissions(applications, current_user)
  end
end
