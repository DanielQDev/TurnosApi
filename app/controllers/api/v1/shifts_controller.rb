class Api::V1::ShiftsController < ApplicationController
  before_action :set_shift, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[index confirmed created update show destroy]

  include Authenticable

  def index
    @shifts = Shift::GetShifts.new(@current_user, params).all

    if @shifts.empty?
      @shifts = Shift::ShiftGenerator.new(@current_user, params).create
    end

    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @shifts,
        each_serializer: Shifts::ShiftSerializer
      )
    ), status: :ok
  end

  def confirmed
    @shifts = Shifts::GetConfirmedShifts.new(params).all

    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @shifts,
        each_serializer: Shifts::ConfirmedShiftSerializer
      )
    ), status: :ok
  end

  def show
    render json: @shift
  end

  def create
    @shift = Shift.new(shift_params)

    if @shift.save
      render json: Shifts::ShiftSerializer.new.serialize_to_json(@shift), status: :created
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def update
    if @shift.update(shift_params)
      render json: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shift.destroy!
    head 204
  end

  private
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:start_hour, :end_hour, :is_confirmed, :user_id, :schedule_id, :company_id)
    end

    def set_current_user
      head :forbidden if current_user.nil?
      @current_user = current_user
    end
end
