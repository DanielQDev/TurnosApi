class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
	before_action :check_owner, only: %i[update destroy]

  def show
		render(
			json: Panko::Response.create do |r|
				{
					success: true,
					user: r.serializer(@user, Users::UserSerializer)
				}
			end, status: :ok
		)
	end

	def update
		if @user.update(user_params)
			render json: Users::UserSerializer.new.serialize(@user).to_json, status: :ok
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy
		head 204
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :first_name, :last_name, :role, :color)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def check_owner
		head :forbidden unless @user.id == current_user&.id
	end

end
