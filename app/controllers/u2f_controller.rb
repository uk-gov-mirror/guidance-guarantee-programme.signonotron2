class U2fController < ActionController::Base
  layout 'admin_layout'

  def new
    # u2f = U2F::U2F.new("http://signon.dev.gov.uk")
    u2f = U2F::U2F.new("https://ingens.serveo.net")

    # Generate one for each version of U2F, currently only `U2F_V2`
    @registration_requests = u2f.registration_requests

    # Store challenges. We need them for the verification step
    session[:challenges] = @registration_requests.map(&:challenge)

    # Fetch existing Registrations from your db and generate SignRequests
    # key_handles = Registration.map(&:key_handle)
    # TwoFactorDevice.create(user: user)
    # key_handles = TwoFactorDevice.where(user: user).map(&:key_handle)

    # "key handles" - unsure what these are and how to generate them
    @sign_requests = u2f.authentication_requests([
      Base64.urlsafe_encode64("One two three")
    ])

    @app_id = u2f.app_id
  end

  def create
    u2f = U2F::U2F.new("https://ingens.serveo.net")

    response = U2F::RegisterResponse.load_from_json(
      params[:response]
    )

    reg = begin
      u2f.register!(session[:challenges], response)
    rescue U2F::Error => e
      render text: "Unable to register: <%= e.class.name %>"
    ensure
      session.delete(:challenges)
    end

    # save a reference to your database
    Device.create!(
      certificate: reg.certificate,
      key_handle: reg.key_handle,
      public_key: reg.public_key,
      counter: reg.counter
    )

    render json: ["REGISTERED", reg.inspect]
  end
end
