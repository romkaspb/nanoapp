class ApiController < ActionController::API
  before_action :ensure_authenticated_user

  protected

  def ensure_authenticated_user
    head :unauthorized unless current_user
  end

  def current_user
    api_key = ApiKey.where(access_token: token).first

    if api_key && !api_key.is_expired? && !api_key.locked
      @current_user = api_key.user
      @current_user.current_api_key = api_key
    else
      return nil
    end
  end

  def token
    authorization_header = request.headers['Authorization']
    return nil unless authorization_header.present?

    access_token = authorization_header.split(' ')[1]

    access_token if access_token.present?
   end
end