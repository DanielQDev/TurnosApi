module Shifts
  class GetConfirmedShifts
    def initialize(params)
      @week ||= get_week(params[:week_number])
      @company_id ||= get_company(params[:company_id].to_i)
    end

    def all
      Shift.by_confirmed_user(@week, @company_id)
    end

    def get_week(week)
      week.blank? ? Time.now.strftime('%U') : week
    end

    def get_company(id)
      id == 0 ? Company.first.id : id
    end
  end
end
