class UsersWithAccessToOnlyPensionWiseAcademy
  PENSION_WISE_ACADEMY_APP_NAME = ENV.fetch('PENSION_WISE_ACADEMY_APP_NAME') { 'Pension Wise Academy' }

  def user_ids
    return unless application

    UserApplicationPermission.where(
      supported_permission: application.signin_permission,
      application:
    ).where(
      user_id: UserApplicationPermission
        .group(:user_id)
        .having('count(user_id) = 1')
        .select(:user_id)
    ).pluck(:user_id)
  end

  private

  def application
    @application ||= Doorkeeper::Application.find_by_name(PENSION_WISE_ACADEMY_APP_NAME)
  end
end
