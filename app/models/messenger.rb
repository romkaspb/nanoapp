class Messenger < ApplicationRecord
	validates :name, presence: true

	# method will be redefined in inherited models
	def self.send_message
		logger.debug( "Message was sent via #{self.class}" )
		# simple hack to check delivered\not delivered message
		rand(0..1) == 0 ? false : true
	end

	# method that chack validity of identifier, redefined in inherited model, by default all valid
	def identifier_valid?( identifier )
		true
	end
end
