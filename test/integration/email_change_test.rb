require 'test_helper'
require 'helpers/user_account_operations'

class EmailChangeTest < ActionDispatch::IntegrationTest
  include UserAccountOperations
  include ActiveJob::TestHelper

  context "by an admin" do
    setup do
      @admin = create(:admin_user)
    end

    context "for an active user" do
      should "send a notification email and not confirmation email" do
        perform_enqueued_jobs do
          user = create(:user)

          visit new_user_session_path
          signin_with(@admin)
          admin_changes_email_address(user: user, new_email: "new@email.com")

          assert_equal "new@email.com", last_email.to[0]
          assert_match /Your .* Signon development email address has been updated/, last_email.subject
        end
      end

      should "log the event in the user's event log" do
        perform_enqueued_jobs do
          user = create(:user, email: 'old@email.com')

          visit new_user_session_path
          signin_with(@admin)
          admin_changes_email_address(user: user, new_email: "new@email.com")

          visit event_logs_user_path(user)
          assert_response_contains "Email changed by #{@admin.name} from old@email.com to new@email.com"
        end
      end

      should "show an error and not trigger a notification if the email is blank" do
        user = create(:user)

        visit new_user_session_path
        signin_with(@admin)
        admin_changes_email_address(user: user, new_email: "")

        assert_response_contains("Email can't be blank")
        assert_nil last_email
      end
    end

    context "for a user who hasn't accepted their invite yet" do
      should "resend the invitation" do
        perform_enqueued_jobs do
          ActionMailer::Base.deliveries.clear
          user = User.invite!(name: "Jim", email: "jim@web.com")

          open_email("jim@web.com")
          assert_equal 'Please confirm your account', current_email.subject

          visit new_user_session_path
          signin_with(@admin)
          admin_changes_email_address(user: user, new_email: "new@email.com")

          email = emails_sent_to("new@email.com").detect { |mail| mail.subject == 'Please confirm your account' }
          assert email
          assert email.body.include?("Accept invitation")
          assert user.accept_invitation!
        end
      end
    end

    context "when the change was made in error" do
      should "be cancellable" do
        use_javascript_driver

        user = create(:user_with_pending_email_change)

        confirmation_token = token_sent_to(user)
        original_email = user.email

        visit new_user_session_path
        signin_with(@admin)
        visit edit_user_path(user)
        click_link "Cancel email change"
        signout

        visit user_confirmation_path(confirmation_token: confirmation_token)
        assert_response_contains("Couldn't confirm email change. Please contact support to request a new confirmation email.")
        assert_equal original_email, user.reload.email
      end
    end
  end

end
