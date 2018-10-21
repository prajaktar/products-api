class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authenticate

  def login
    user = User.find_by(email: params.require(:email))
    if user && user.authenticate(params.require(:password))
      add_authorization_reponse_header(user)
      render_with_options(
        json: { success: 'User logged in successfully'},
        status: :ok
      )
    else
      render_with_options(
        json: { error: 'Please enter valid email/password pair.' },
        status: 401
      )
    end
  end
end