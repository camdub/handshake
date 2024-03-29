class GetConnections
  include Service
  include Virtus.model
  include ActiveModel::Validations

  attribute :user, User, default: nil
  attribute :linkedin, LinkedIn::Client
  attribute :set_cache, Proc, default: proc { SetConnectionCache }
  attribute :get_cache, Proc, default: proc { CheckConnectionCache }

  validates! :user, presence: true

  def initialize(*args)
    super
    valid?
    self.linkedin = LinkedIn::Client.new scope: %i(r_basicprofile r_network)
    self.linkedin.access_token = user.linkedin_access_token
  end

  def call
    ids = User.linkedin_ids user
    connections = get_connections
    api_ids = connections.collect { |i| i.id }
    intersect = ids & api_ids

    connections.select! { |i| intersect.include? i.id }
    users = User.where(linkedin_id: ids & api_ids).all

    connections.collect! do |item|
      user = users.find { |u| u.linkedin_id == item.id }
      item.merge user.serializable_hash
    end
  end

  private
  def get_connections
    cache = get_cache.call(user: user)
    if cache.nil?
      conns = linkedin.profile.connections.values[3]
      set_cache.call(user: user, data: conns)
      conns
    else
      cache
    end
  end
end
