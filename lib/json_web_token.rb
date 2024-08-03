class JsonWebToken
  SECRET_KEY = "Rails.application.credendials.secret_key_base.to_s"

  def self.encode(user_id, exp = 24.hours.from_now)
    payload = {id: user_id, exp: exp.to_i}
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first
    HashWithIndifferentAccess.new decoded
  end
end