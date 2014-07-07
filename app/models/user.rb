class User < ActiveRecord::Base

  scope :linkedin_ids, ->(user) { where.not(id: user.id).pluck(:linkedin_id) }

  devise :database_authenticatable, :registerable

  validates_uniqueness_of    :email,     :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?

  has_many :user_profiles, autosave: true
  has_many :account_settings, autosave: true

  before_save :ensure_access_token

  after_create  :set_account_settings
  after_create  :set_user_profiles

  def set_account_settings

    if Setting.exists?
      Setting.all.each do |tmp_setting|
        AccountSetting.create(:user => self, :setting => tmp_setting, :enabled => false)
      end
    end

  end

  def set_user_profiles

    if ProfileType.exists?
      ProfileType.all.each do |temp_profile_type|
        UserProfile.create(:user => self, :profile_type => temp_profile_type, :handshake_user_name => true, :full_name => true, :company => true, :title => true, :picture => true, :phone_number => true)
      end
    end

  end

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
