class Api::V1::MessagesController < Api::V1Controller
	def create
		
	end

	private

	def message_params
		params.requre(:message).permit(:body, recipient_messager: [], :recipient_id )
	end
end
