module Authenticable
  extend ActiveSupport::Concern
  
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decode = JsonWebToken.decode(header)

    @current_user = User.find(decode[:id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_login
    head :forbidden unless self.current_user
  end
end