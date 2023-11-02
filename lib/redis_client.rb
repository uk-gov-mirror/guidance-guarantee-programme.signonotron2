require 'redis'

class RedisClient
  include Singleton

  attr_reader :connection

  def initialize
    @connection = Redis.new(
      url: ENV['REDIS_URL'],
      ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
    )
  end
end
