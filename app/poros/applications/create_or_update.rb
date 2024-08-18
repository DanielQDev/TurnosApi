module Applications
  class CreateOrUpdate
    def initialize(user_id, params)
      @shift_id = params[:shift_id]
      @user_id = user_id
    end

    def apply_shift
      application = Application.find_by(user_id: @user_id, shift_id: @shift_id)
      
      if application.nil?
        application = Application.create(user_id: @user_id, shift_id: @shift_id, is_confirmed: false)
      else
        if application.is_confirmed.nil?
          application.update(is_confirmed: false)
        elsif !application.is_confirmed?
          application.update(is_confirmed: nil)
        end
      end

      application
    rescue StandardError => e
      Rails.logger.error e
    end
  end
end