class Messenger::Viber < Messenger
	def self.send_message
		super
	end

	# viber identifier must containt email i guess
	def identifier_valid?( identifier )
		identifier =~ /@/
	end
end
