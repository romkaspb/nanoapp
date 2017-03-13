class Api::V1::MessagesController < Api::V1Controller
	def create
		parameters = message_params
		@messages = []

		@messengers.each do |messenger_id|
			message = Message.new( parameters.merge({ messenger_id: messenger_id }) )
			message.sender = @current_user
			if message.valid?
				message.save
				@messages << @message
			else
				return render_error message.errors.full_messages.first
			end
		end

		HandleMessageJob.perform_later( @messages )
		head :created
	end

	private

	def message_params
		parameters = params.require(:message).permit(:body, :recipient_id, :delivery_at, recipient_messengers: [] )
		messengers = parameters.delete(:recipient_messengers)
		@messengers = messengers.nil? ? [] : messengers.is_a?(Array) ? messengers : [ messengers ]

		parameters
	end
end
