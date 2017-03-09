class ApiKey < ApplicationRecord
  self.primary_key = 'access_token'

  belongs_to :user

  validates :user, presence: true

  before_create :generate_access_token, :set_expiry_date

  def set_expiry_date
    self.expires_at = 1.year.from_now
  end

  def generate_access_token
    payload = {
      user_id: user.id,
      name: user.name,
      access_timestamp: Time.now.to_i,
    }
    hmac_secret = 'freeman'
    self.access_token = JWT.encode payload, hmac_secret, 'HS256'
  end

  def is_expired?
    expires_at <= Time.zone.now ? true : false
  end
end