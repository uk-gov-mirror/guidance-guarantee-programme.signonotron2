class U2fLoginController < ActionController::Base
  layout 'admin_layout'

  def new
    # u2f = U2F::U2F.new("http://signon.dev.gov.uk")
    u2f = U2F::U2F.new("https://ingens.serveo.net")

    key_handles = Device.all.map(&:key_handle)

    # Generate SignRequests
    @app_id = u2f.app_id
    @sign_requests = u2f.authentication_requests(key_handles)
    @challenge = u2f.challenge

    # Store challenge. We need it for the verification step
    session[:challenge] = @challenge
  end

  # authentications_controller.rb
  def create
    u2f = U2F::U2F.new("https://ingens.serveo.net")

    response = U2F::SignResponse.load_from_json(params[:response])

    registration = Device.first # get user key by handle
    return 'Need to register first' unless registration

    # begin
      u2f.authenticate!(
        session[:challenge], response,
        Base64.decode64(registration.public_key),
        registration.counter
      )
    # rescue U2F::Error => e
    #   return "Unable to authenticate: <%= e.class.name %>"
    # ensure
    #   session.delete(:challenge)
    # end

    registration.update!(counter: response.counter)

    render text: 'Authenticated!'
  end
end
