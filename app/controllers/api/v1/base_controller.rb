class Api::V1::BaseController < ApplicationController
  respond_to :json
  before_action :authenticate

  def logged_in?
    !!current_user
  end

  def current_user
    if authenticated? && !auth.respond_to?(:exception)
      user = User.find(auth['user_id'])
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    if current_user.present?
      add_authorization_reponse_header(@current_user) && return
    end
    error_message =
      if auth.eql?(JWT::ExpiredSignature)
        "Sorry, this token is expired."
      else
        "Unauthorised user"
      end
    render json: { error: error_message }, status: :unauthorized
  end

  private

  def token
    request.env['HTTP_AUTHORIZATION']&.scan(/Bearer (.*)$/)&.flatten&.last
  end

  # decode will return the error class if it fails to decode
  def auth
    @decoded_token ||= Auth.decode(token)
  end

  def authenticated?
    !!request.env.fetch('HTTP_AUTHORIZATION', '').scan(/Bearer/).flatten.first
  end

  protected

  def render_with_options(options = {})
    render options.merge(content_type: request.content_type) and return
  end

  # This is the token used for authenticating a request
  def add_authorization_reponse_header(user)
    response.set_header('Authorization', Auth.generate_token(user))
  end
end 