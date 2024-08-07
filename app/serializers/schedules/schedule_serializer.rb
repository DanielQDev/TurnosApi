module Schedules
  class ScheduleSerializer < BaseSerializer
    attributes :id, :start_hour, :end_hour, :duration, :weekend
  end
end
