module Shifts
  class Schedule
    def initialize(shift)
      @shift = shift
    end

    def summary
      {
        start_hour: @shift.start_hour.strftime('%H:%M'),
        end_hour: @shift.end_hour.strftime('%H:%M'),
        is_confirmed: @shift.is_confirmed,
        is_postulated: @shift.is_postulated
      }
    end
  end
end