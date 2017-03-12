class User < ApplicationRecord
  has_many :api_keys, foreign_key: :user_id, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :user_identifiers, dependent: :destroy, class_name: 'User::Identifier'
  has_many :messengers, through: :user_identifiers, class_name: 'User::Identifier'

  has_secure_password

  attr_accessor :current_api_key
end
