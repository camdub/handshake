require 'mock_redis'

class SetConnectionCache
  include Service
  include Virtus.model

  attribute :data, Object
  attribute :user, User
  attribute :redis, Object

  def initialize(*args)
    super
    url = ENV['REDIS_URL']
    self.redis = url ? Redis.new(url: url) : MockRedis.new
  end

  def call
    redis.hset('connections', user.user_name, data)
  end
end
