require 'jwt'

class Auth
  def self.generate_token(payload)
    payload = { exp: JWT_EXPIRY.minutes.from_now.to_i,
                user_id: payload.id,
                name: payload.name }
    jwt_secret = Rails.application.secrets.secret_key_base
    algorithm = 'HS256'
    JWT.encode(payload, jwt_secret, algorithm)
  end

  def self.decode(token)
    jwt_secret = Rails.application.secrets.secret_key_base
    algorithm = 'HS256'
    JWT.decode(token,
               jwt_secret,
               true,
               { algorithm: algorithm }).first

  rescue => exception
    exception.class
  end
end
