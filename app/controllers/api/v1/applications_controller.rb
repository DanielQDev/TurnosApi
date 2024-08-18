class Api::V1::ApplicationsController < ApplicationController
  before_action :set_current_user, only: :create

  include Authenticable

  def create
    @application = Applications::CreateOrUpdate.new(@current_user.id, application_params).apply_shift

    if !@application.nil?
      render json: @applications, status: :created
    else
      render json: 'An error has occurred in the process, reload and try again.', status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:application).permit(:is_confirmed, :shift_id)
  end

  def set_current_user
    @current_user = current_user
    head :forbidden if @current_user.nil?
  end
end
