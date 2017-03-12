class Api::V1::SessionsController < Api::V1Controller
  skip_before_action :ensure_authenticated_user

  def create
    user = User.where('email = ?', params[:email]).first

    if user
      if user.authenticate(params[:password])
        api_key = ApiKey.find_or_create_by(user_id: user.id)

        if !api_key.locked
          api_key.last_access = Time.now

          if !api_key.access_token || api_key.is_expired?
            api_key.set_expiry_date
            api_key.generate_access_token
          end
          api_key.save!

          render json: { user: user, token: api_key }, status: 201
        else
          render_error 'Your account has been locked'
        end
      else
        render_error 'Incorrect email or password'
      end
    else
      render_error 'Could not authenticate properly'
    end
  end

  def destroy
    @current_user.current_api_key.destroy
    head :no_content
  end
end
