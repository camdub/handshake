class User < ActiveRecord::Base

  scope :linkedin_ids, ->(user) { where.not(id: user.id).pluck(:linkedin_id) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_profiles
  has_many :account_settings

  before_save :ensure_access_token

  def ensure_access_token
    self.handshake_access_token ||= generate_token
  end

  def generate_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(handshake_access_token: token).first
    end
  end
end
