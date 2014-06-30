class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_profiles, autosave: true
  has_many :account_settings, autosave: true

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
