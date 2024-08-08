module Shifts
  class ShiftGenerator
    def initialize(user, params)
      @user = user
      @week = params[:week]
      @company_id = params[:company_id]
      @new_shifts = []
    end

    def create
      get_schedule.each do |schedule|
        if schedule.weekend
          2.times{ generate(schedule) }
        else
          5.times{ generate(schedule) }
        end
      end

      @new_shifts
    end

    def get_schedule
      Contract.find_by(company_id: @company_id).schedules
    end

    def generate(schedule)
      shift_hour = schedule.start_hour
      while(shift_hour < schedule.end_hour)
        shift = Shift.new
        shift.start_hour = shift_hour
        shift.end_hour = shift_hour.advance(minutes: schedule.duration)
        shift.is_confirmed = false
        shift.week = @week
        shift.user_id = @user.id
        shift.company_id = @company_id
        shift.schedule = schedule.id
        shift.save
        @new_shifts << shift
        shift_hour = shift.end_hour
      end
    end
  end
end
