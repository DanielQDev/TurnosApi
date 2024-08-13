module Shifts
  class GeneratorShifts
    def initialize(user, params)
      @user = user
      @week = params[:week]
      @company_id = params[:company_id]
    end

    def create
      get_schedule.each do |schedule|
        if schedule.weekend
          days_for_saturday = (6 - (Time.now.wday + 7)) % 7
          start = Time.now.advance(days: days_for_saturday)
          2.times do |i|
            start = start.change(hour: schedule.start_hour.hour)
            
            while(start.hour < schedule.end_hour.hour)
              Shift.create(start_hour: start, end_hour: start.advance(minutes: schedule.duration), week: start.strftime('%U'), user_id: @user.id, schedule_id: schedule.id, company_id: @company.id)
              start = Shift.last.end_hour
            end
            start = start.advance(days: 1)
          end
        else
          days_for_monday = (1 - (Time.now.wday + 7)) % 7
          start = Time.now.advance(days: days_for_monday)
          5.times do |i|
            start = start.change(hour: schedule.start_hour.hour)
            
            while(start.hour < schedule.end_hour.hour)
              Shift.create(start_hour: start, end_hour: start.advance(minutes: schedule.duration), week: start.strftime('%U'), user_id: @user.id, schedule_id: schedule.id, company_id: @company.id)
              start = Shift.last.end_hour
            end
            start = start.advance(days: 1)
          end
        end
      end
    end

    def get_schedule
      Contract.find_by(company_id: @company_id).schedules
    end
  end
end
