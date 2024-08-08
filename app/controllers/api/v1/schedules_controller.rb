class Api::V1::SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[index show create update destroy]

  include Authenticable

  def index
    @schedules = Schedule.all

    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @schedules,
        each_serializer: Schedules::ScheduleSerializer
      )
    ), status: :ok 
  end

  def show
    render(
			json: Panko::Response.create do |r|
				{
					success: true,
					user: r.serializer(@schedule, Schedules::ScheduleSerializer)
				}
			end, status: :ok
		)
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render json: Schedules::ScheduleSerializer.new.serialize_to_json(@schedule), status: :created
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def update
    if @schedule.update(schedule_params)
      render json: Schedules::ScheduleSerializer.new.serialize_to_json(@schedule), status: :ok
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy!
    head 204
  end

  private

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:start_hour, :end_hour, :duration, :weekend, :contract_id)
    end

    def set_current_user
      head :forbidden if current_user.nil?
      @current_user = current_user
    end
end
