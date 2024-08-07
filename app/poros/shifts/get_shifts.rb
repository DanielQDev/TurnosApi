module Shift
  class GetShifts
    def initialize(user,params)
      @user ||= user
      @week ||= params[:week]
      @company_id ||= params[:company_id]
    end

    def all
      @user.shifts.where(week: @week, company_id: @company_id)
    end

  end
end