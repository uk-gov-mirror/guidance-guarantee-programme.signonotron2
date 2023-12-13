class ApplicationPolicy < BasePolicy
  def index?
    current_user.superadmin?
  end
  alias edit? index?
  alias update? index?
  alias manage_supported_permissions? index?
  alias users_with_access? index?
end
