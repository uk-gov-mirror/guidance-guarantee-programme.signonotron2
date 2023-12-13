module SameSiteSecurity
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      status, headers, response = @app.call(env)
      if (cookies = headers['Set-Cookie'])
        cookies = cookies.split("\n") unless cookies.is_a?(Array)

        headers['Set-Cookie'] = cookies.map do |cookie|
          "#{cookie}; SameSite=Lax"
        end.join("\n")
      end
      [status, headers, response]
    end
  end
end
