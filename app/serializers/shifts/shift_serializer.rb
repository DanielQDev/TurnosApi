module Shifts
  class ShiftSerializer < BaseSerializer
    attributes :id, :start_hour, :postulated

    def postulated
      Shifts::IsPostulated.new(object, context[:user]).call
    end
  end
end
