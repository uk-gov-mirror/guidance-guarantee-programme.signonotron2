require 'test_helper'

class Superadmin::AuthorisationsControllerTest < ActionController::TestCase

  setup do
    @api_user = create(:api_user)
  end

  context "as admin user" do
    setup do
      @admin = create(:admin_user)
      sign_in @admin
    end

    should "not be able to authorise API users" do
      get :new, api_user_id: @api_user.id

      assert_redirected_to root_path
      assert_equal "You do not have permission to perform this action.", flash[:alert]
    end

    should "not be able to revoke API user's authorisations" do
      access_token = create(:access_token, resource_owner_id: @api_user.id)

      get :revoke, api_user_id: @api_user.id, id: access_token.id

      assert_redirected_to root_path
      assert_equal "You do not have permission to perform this action.", flash[:alert]
    end
  end

  context "as superadmin" do
    setup do
      @superadmin = create(:superadmin_user)
      sign_in @superadmin

      @application = create(:application)
    end

    context "GET new" do
      should "should show a form to authorise api access to a particular application" do
        get :new, api_user_id: @api_user.id
        assert_select "option[value='#{@application.id}']", @application.name
      end
    end

    context "POST create" do
      should "create a new access token and populate flash with it" do
        assert_difference 'Doorkeeper::AccessToken.count', 1 do
          post :create, api_user_id: @api_user.id, doorkeeper_access_token: { application_id: @application.id }
        end

        token = Doorkeeper::AccessToken.last
        assert_equal({ application_name: token.application.name, token: token.token }, flash[:authorisation])
      end

      should "add a 'signin' permission for the authorised application" do
        post :create, api_user_id: @api_user.id, doorkeeper_access_token: { application_id: @application.id }

        assert_include @api_user.permissions.find_by_application_id(@application.id).permissions, "signin"
      end
    end
  end
  # it is not possible to test non-restful routes GET /revoke here,
  # so tested it in integration tests.
end
