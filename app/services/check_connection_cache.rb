require 'mock_redis'

class CheckConnectionCache
  include Service
  include Virtus.model

  attribute :redis, Object
  attribute :user, User

  def initialize(*args)
    super
    url = ENV['REDIS_URL']
    self.redis = url ? Redis.new(url: url) : MockRedis.new
  end

  def call
    redis.hget('connections', user.user_name)
  end

end
