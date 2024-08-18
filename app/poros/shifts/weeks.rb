module Shifts
  class Weeks
    def initialize(user)
      @user = user
    end

    def all
      get_shift_of_week
    end

    def get_shift_of_week
      shifts_of_week = Shift.weeks.group_by{|shift| shift.week}
      shifts_of_week.values.map { |shift_of_week| shift_of_week.first }
    end
  end
end