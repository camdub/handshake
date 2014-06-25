class FindNearbyConnections
  include Service
  include Virtus.model
  include ActiveModel::Validations

  attribute :connection_type, String, default: nil
  attribute :user, User, default: nil

  # dependencies
  attribute :geocoder, Proc, default: proc { CalculateDistance }
  attribute :connections, Proc, default: proc { GetConnections }

  validates! :user, presence: true
  validates! :connection_type, inclusion: { in: %w(first second handshake) }

  def call
    valid?
    connections.call(user: user).select do |c|
      geocoder.call(user: user, connection: c)
    end
  end

end
