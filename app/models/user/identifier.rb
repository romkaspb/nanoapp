class User::Identifier < ApplicationRecord
	belongs_to :user
	belongs_to :messenger

	validates :identifier, :user, :messenger, presence: true
	validates :user, uniqueness: { 	scope: :messenger }
	validate :identifier_format

	def identifier_format 
		unless messenger.identifier_valid?( identifier )
			errors.add(:identifier, " is not valid for the messenger")
		end
	end
end
