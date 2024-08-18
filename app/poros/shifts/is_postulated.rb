module Shifts
  class IsPostulated
    def initialize(shift, user)
      @shift = shift
      @user = user
    end
    
    def call
      application = @shift.applications.where(user_id: @user.id)

      if application.empty?
        return false
      else
        if application.first.is_confirmed.nil?
          return false
        else
          return true
        end
      end
    end
  end
end
