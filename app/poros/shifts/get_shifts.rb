module Shifts
  class GetShifts
    def initialize(user,params)
      @user ||= user
      @week ||= get_week(params[:week_number])
      @company_id ||= get_company(params[:company_id].to_i)
    end

    def all
      Shift.for_user(@week, @company_id)
    end

    def get_week(week)
      week.blank? ? Time.now.strftime('%U') : week
    end

    def get_company(id)
      id == 0 ? @user.shifts.first.company_id : id
    end
    
  end
end