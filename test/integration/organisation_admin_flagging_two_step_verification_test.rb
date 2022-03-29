require 'test_helper'

class OrganisationAdminFlaggingTwoStepVerificationTest < ActionDispatch::IntegrationTest
  include EmailHelpers
  include ActiveJob::TestHelper

  context 'updating a user' do
    setup do
      organisation_admin = create(:organisation_admin)
      @user = create(:user_in_organisation, organisation: organisation_admin.organisation)
      visit root_path
      signin_with(organisation_admin)

      visit edit_user_path(@user)
    end

    context 'when the user is flagged for 2SV' do
      should 'notify the user by email' do
        perform_enqueued_jobs do
          check 'Ask user to set up 2-step verification'
          click_button 'Update User'
        end

        assert last_email
        assert_equal 'Make your Signon account more secure', last_email.subject
        assert @user.reload.require_2sv?
      end
    end
  end
end
