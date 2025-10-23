require 'jwt'
class JsonWebToken
  
  SECRET_KEY = ENV['SECRET_KEY']

  def encode_token(user_id, user_flag, exp=30.minutes.from_now)
    payload = {
      user_id: user_id,
      user_flag: user_flag,
      exp: exp.to_i
    }
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature
    raise JWT::DecodeError, 'Token has expired!'
  rescue JWT::DecodeError
    raise JWT::DecodeError, 'Error decoding token!'
  end
end