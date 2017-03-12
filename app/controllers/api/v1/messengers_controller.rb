class Api::V1::MessengersController < Api::V1Controller
	before_action :set_messenger, only: [:update, :destroy]

	def create
		@messenger = @current_user.messengers.build( messenger_params )
		@messenger.user = @current_user

		logger.debug( @messenger.inspect )
		if @messenger.save
			render json: @messenger
		else
			render_error @messenger.errors.full_messages.first
		end
	end

	def index
		render json: @current_user.messengers
	end

	def update
		if @messenger.update( messenger_params )
			render json: @messenger
		else
			render_error @messenger.errors.full_messages.first
		end
	end

	def destroy
		if @messenger.destroy
			head :no_content
		else
			render_error 'System error'
		end
	end

	private

	def messenger_params
		params.require(:messenger).permit(:messenger_id, :identifier )
	end

	def set_messenger
		@messenger = @current_user.messengers.find(params[:id])
	end
end
