class Api::V1::SessionController < Api::V1Controller
  def create
    user = User.where('email = ?', params[:email]).first

    if user
      if user.authenticate(params[:password])
        api_key = user.find_api_key

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
