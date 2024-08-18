class Api::V1::ShiftsController < ApplicationController
  before_action :set_shift, only: %i[ show verify_assignment confirmed update destroy ]
  before_action :set_current_user, only: %i[ index show confirmed weeks create update destroy ]

  include Authenticable

  def index
    @shifts = Shifts::GetShifts.new(@current_user, params).all

    # if @shifts.empty?
    #   # Shifts::GeneratorShifts.new(@current_user, params).create
    #   @shifts = Shifts::GetShifts.new(@current_user, params).all
    # end

    render json: @shifts, status: :ok
  end

  def confirmed
    # @shifts = Shifts::GetConfirmedShifts.new(params).all
    # @shifts = Shifts::GetShifts.new(@current_user, params).all
    @users = @shift.company.users
    # if @shifts.empty?
    #   Shift::ConfirmShifts.new(params[:week], params[:company_id]).confirm
    #   @shifts = Shifts::GetConfirmedShifts.new(params).all
    # end

    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @users,
        each_serializer: Shifts::UserConfirmedSerializer,
        context: { shift: @shift }
      )
    ), status: :ok
  end

  def weeks
    @shifts = Shifts::Weeks.new(@current_user).all
    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @shifts,
        each_serializer: Shifts::WeekSerializer
      )
    ), status: :ok
  end

  def show
    render(json: Panko::Response.create do |r|
      r.serializer(
        @shift,
        Shifts::ShiftSerializer,
        context: {user: @current_user}
      )
    end,
    status: :ok)
  end

  def verify_assignment
    render json: Shifts::AssignmentSerializer.new.serialize_to_json(@shift), status: :ok
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
      params.require(:shift).permit(:start_hour, :end_hour, :schedule_id, :company_id)
    end

    def set_current_user
      @current_user = current_user
      head :forbidden if current_user.nil?
    end
end
