module Shifts
  class ShiftSerializer < BaseSerializer
    attributes :id, :start_hour, :end_hour, :is_confirmed, :is_postulated, :week
  end
end
