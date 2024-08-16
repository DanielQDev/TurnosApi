class Api::V1::AuthController < ApplicationController

  def signin
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      token = set_token(@user.id)

			render json: {user: {id: @user.id, email: @user.email, name: @user.first_name}, authorization: token}, status: :ok
    else
      render json: {"msg": "User not found."}, status: :not_found
    end
  rescue StandardError => e
    Rails.logger.error e
    render json: {"msg": "An error has been generated in the process."}, status: :internal_server_error
  end

  def signup
    @user = User.new(user_params)
		if @user.save
      token = set_token(@user.id)

			render json: {user: {id: @user.id, email: @user.email, name: @user.first_name}, authorization: token}, status: :created
		else
			render json: {"msg": "Incorrect registration data"}, status: :unprocessable_entity
		end
  rescue StandardError => e
    Rails.logger.error e
    render json: {"msg": "An error has been generated in the process."}, status: :internal_server_error
  end

  def check_status
    header = request.headers['Authorization']
    if header.nil?
      render json: {"msg": "The token has not been sent"}, status: :forbidden
    else
      decode = JsonWebToken.decode(header)
      if Time.now < Time.at(decode[:exp])
        @user = User.find(decode[:id])
        new_token = set_token(@user.id)

        render json: {user: {id: @user.id, email: @user.email, name: @user.first_name}, authorization: new_token}, status: :ok
      end
    end
  rescue StandardError => e
    Rails.logger.error e
    render json: {"msg": "Token expired or invalid."}, status: :forbidden
  end

  private

  def set_token(user_id)
    JsonWebToken.encode(user_id)
  end

  def user_params
		params.require(:user).permit(:email, :password, :first_name, :last_name, :role, :color)
	end
  
end
