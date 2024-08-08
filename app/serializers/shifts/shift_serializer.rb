module Shifts
  class ShiftSerializer < BaseSerializer
    attributes :date, :schedule

    def date
      object.day_format
    end

    def schedule
      Schedule.new(object).summary
    end
  end
end
