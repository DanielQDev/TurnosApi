module Shifts
  class GetApplications
    def initialize(shift, user)
      @shift = shift
      @user = user
    end

    def application
      Application.where(user_id: @user.id, shift_id: @shift.id).exist?
    end
  end
end