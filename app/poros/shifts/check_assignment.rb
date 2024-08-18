module Shifts
  class CheckAssignment
    def initialize(shift)
      @shift ||= shift
    end

    def user_name
      assigned_user&.first_name&.capitalize || ''
    end

    def user_color
      assigned_user&.color || '#FFEC33'
    end

    def assigned_user
      application_confirmed.first&.user
    end

    def application_confirmed
      @shift.applications.where(is_confirmed: true)
    end

  end
end