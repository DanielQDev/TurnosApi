module Shift
  class GetConfirmedShifts
    def initialize(params)
      @week = params[:week]
      @company_id = params[:company_id]
    end

    def all
      Shift.where(week: @week, company_id: @company_id)
    end
  end
end
