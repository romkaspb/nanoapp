class Messenger::Telegram < Messenger
	def self.send_message
		super
	end

	def identifier_valid?( identifier )
		identifier =~ /^\d*$/
	end
end
