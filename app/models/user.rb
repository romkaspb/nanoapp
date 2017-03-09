class User < ApplicationRecord
  has_many :api_keys, foreign_key: :user_id, dependent: :destroy

  has_secure_password
end
