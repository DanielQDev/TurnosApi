module Shifts
  class AssignmentSerializer < BaseSerializer
    attributes :name, :color

    def name
      Shifts::CheckAssignment.new(object).user_name
    end

    def color
      Shifts::CheckAssignment.new(object).user_color
    end
  end
end