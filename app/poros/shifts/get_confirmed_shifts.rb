module Shifts
  class GetConfirmedShifts
    def initialize(params)
      @week = params[:week]
      @company_id = params[:company_id]
    end

    def all
      if Shift.availables(@week, @company_id).empty?
        Shift.where(week: @week, company_id: @company_id)
      else
        Shift.confirm(@week, @company_id)
        Shift.where(week: @week, company_id: @company_id)
      end
    end
  end
end
