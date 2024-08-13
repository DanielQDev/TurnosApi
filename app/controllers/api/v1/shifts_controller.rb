class Api::V1::ShiftsController < ApplicationController
  before_action :set_shift, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[ index confirmed weeks create update show destroy]

  include Authenticable

  def index    
    @shifts = Shifts::GetShifts.new(@current_user, params).all

    if @shifts.empty?
      Shifts::GeneratorShifts.new(@current_user, params).create
      @shifts = Shifts::GetShifts.new(@current_user, params).all
    end

    render json: @shifts, status: :ok
  end

  def confirmed
    @shifts = Shifts::GetConfirmedShifts.new(params).all
    if @shifts.empty?
      Shift::ConfirmShifts.new(params[:week], params[:company_id]).confirm
      @shifts = Shifts::GetConfirmedShifts.new(params).all
    end

    render json: @shifts, status: :ok
  end

  def weeks
    @shifts = Shifts::Weeks.new(User.find(1)).all
    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @shifts,
        each_serializer: Shifts::WeekSerializer
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
      render json: Shifts::ShiftSerializer.new.serialize(@shift).to_json, status: :ok
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
      params.require(:shift).permit(:start_hour, :end_hour, :is_confirmed, :is_postulated, :user_id, :schedule_id, :company_id)
    end

    def set_current_user
      @current_user = current_user
      head :forbidden if current_user.nil?
    end
end
