module Shifts
  class ShiftConfirmedSerializer < BaseSerializer
    attributes :id, :start_hour, :end_hour, :week, :user_name, :user_color

    def user_name
      object.users.joins(:applications).where(applications: {is_confirmed: true}).first.first_name || ''
    end

    def user_color
      object.users.joins(:applications).where(applications: {is_confirmed: true}).first.color || ''
    end
  end
end