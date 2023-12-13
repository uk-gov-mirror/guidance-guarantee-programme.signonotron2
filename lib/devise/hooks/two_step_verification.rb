module Devise
  module Hooks
    module TwoStepVerification
      Warden::Manager.after_authentication do |user, auth, _options|
        if user.need_two_step_verification?
          cookie = auth.env['action_dispatch.cookies'].signed['remember_2sv_session']
          valid = cookie &&
                  cookie[:user_id] == user.id &&
                  cookie[:valid_until] > Time.zone.now &&
                  cookie[:secret_hash] == Digest::SHA256.hexdigest(user.otp_secret_key)
          auth.session(:user)['need_two_step_verification'] = user.need_two_step_verification? unless valid
        end
      end
    end
  end
end
