class CalculateDistance
  include Service
  include Virtus.model
  include ActiveModel::Validations

  attribute :user, User
  attribute :connection, User
  attribute :radius, Integer, default: 5 # miles

  validates! :user, presence: true
  validates! :connection, presence: true
  validates! :radius, inclusion: 1..50

  def call
    valid?
    distance_between <= 5 ? true : false
  end

  private

  # Distance between two points on Earth computed via Haversine formula.
  # Ruby implementation taken from
  # https://github.com/alexreisner/geocoder/blob/master/lib/geocoder/calculations.rb
  def distance_between
    # convert to coord arrays
    point1 = extract_coords([user.current_latitude, user.current_longitude])
    point2 = extract_coords([connection.current_latitude, connection.current_longitude])

    # convert degrees to radians
    point1 = to_radians(point1)
    point2 = to_radians(point2)

    # compute deltas
    dlat = point2[0] - point1[0]
    dlon = point2[1] - point1[1]

    a = (Math.sin(dlat / 2)) ** 2 + Math.cos(point1[0]) *
      (Math.sin(dlon / 2)) ** 2 * Math.cos(point2[0])
    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
    c * earth_radius
  end

  def extract_coords(point)
    raise ArgumentError unless point.is_a? Array
    lat, lon = point

    if !lat.nil? && lat.respond_to?(:to_f) and
      !lon.nil? && lon.respond_to?(:to_f)
    then
      return [ lat.to_f, lon.to_f ]
    end
  end

  def to_radians(point)
    point.map { |p| p * (Math::PI / 180) }
  end

  # returned in miles
  def earth_radius
    km_in_mi = 0.621371192
    earth_radius_km = 6371.0
    earth_radius_km * km_in_mi
  end

end
