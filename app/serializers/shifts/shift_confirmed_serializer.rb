module Shifts
  class ConfirmedShiftSerializer < BaseSerializer
    attributes :date,

    def date
      object.day_format
    end

    def schedule
      Schedule.new(object).summary
    end
  end
end