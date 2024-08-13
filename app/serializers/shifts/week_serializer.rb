module Shifts
  class WeekSerializer < BaseSerializer
    attributes :week, :title

    def title
      object.week_format
    end
  end
end
