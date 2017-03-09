class Api::V1Controller < ApiController
	def render_error( error )
		render json: { error: error }, status: 422
	end
end
