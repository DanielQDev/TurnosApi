class Api::V1::AuthController < ApplicationController

  def signin
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      token = set_tokens(@user.id)

			render json: {id: @user.id, authorization: token, email: @user.email, username: @user.first_name}, status: :ok
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
      token = set_tokens(@user.id)

			render json: {id: @user.id, authorization: token, email: @user.email, username: @user.first_name}, status: :created
		else
			render json: {"msg": "Incorrect registration data"}, status: :unprocessable_entity
		end
  rescue StandardError => e
    Rails.logger.error e
    render json: {"msg": "An error has been generated in the process."}, status: :internal_server_error
  end

  def refresh
  end

  private

  def set_tokens(user_id)
    access_token = JsonWebToken.encode(user_id)
    # exp = 1.week.from_now
    # refresh_token = JsonWebToken.encode(user_id, exp)

    # cookies[:refresh_token] = {
    #   value: refresh_token,
    #   expires: 1.week.from_now,
    #   httponly: true,
    #   secure: true
    # }

    access_token
  end

  def user_params
		params.require(:user).permit(:email, :password, :first_name, :last_name, :role, :color)
	end
  
end
