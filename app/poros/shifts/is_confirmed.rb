module Shifts
  class IsConfirmed
    def initialize(shift, user_id)
      @shift = shift
      @user_id = user_id
    end
    
    def exists?
      @shift.applications.where(user_id: @user_id, is_confirmed: true).exists?
    end
  end
end