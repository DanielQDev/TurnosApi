module Shifts
  class ConfirmShifts
    def initialize(week, company_id)
      @week = week
      @company_id = company_id
    end

    def confirm
    
      postulates = Application.where(company_id: @company_id, is_confirmed: false)
      ingineers = User.find(postulates.pluck(:user_id).uniq)
      shift_of_week = Shift.where(week: @week, company_id: @company_id)
      postulated_hours = postulated(postulates)
      total_monitoring_hours = total_hours(shift_of_week)
  
      ingineers.each do |ingineer|
        week_hours = ingineer.shifts.joins(:schedule).where(schedule: {weekend: false}).size
        weekend_hours = ingineer.shifts.joins(:schedule).where(schedule: {weekend: true}).size
  
        percent_regular_hours = (week_hours.to_f / postulated_hours[:regular])*100
        percent_extra_hours = (weekend_hours.to_f / postulated_hours[:extra])*100
  
        hours_to_assign = ((percent_regular_hours * total_monitoring_hours[:regular])/100).round
  
        assign_hours(hours_to_assign, ingineer.id)
  
        hours_to_assign_weekend = ((percent_extra_hours / total_monitoring_hours[:extra])/100).round
  
        assign_weekend_hours(hours_to_assign_weekend, ingineer.id)
        
      end
    end
  
    def assign_hours(hours, ingineer_id)
      available_shifts = shift_of_week.joins(:schedule).where(is_confirmed: false, schedule: {weekend: false})
      con = 1
      while(con <= 5)
        available_shifts.select{|shift| shift.start_hour.strftime('%u') == con}
        available_shifts.each do |available_shift|
          x = 1
          if x <= hours / 5
            available_shift.update(is_confirmed: true, user_id: ingineer_id)
            x = x + 1
          else
            break
          end
        end
        con = con + 1
      end
    end
  
    def assign_weekend_hours(hours, ingineer_id)
      available_shifts = postulates.joins(:schedule).where(is_confirmed: false, schedule: {weekend: true})
      con = 1
      while(con <= 2)
        available_shifts.select{|shift| shift.start_hour.strftime('%u') == con}
        available_shifts.each do |available_shift|
          x = 1
          if x <= hours / 2
            available_shift.update(is_confirmed: true, user_id: ingineer_id)
            x = x + 1
          else
            break
          end
        end
        con = con + 1
      end
    end
  
    def total_hours(shift_of_week)
      hours={}
      schedules = Schedule.find(shift_of_week.pluck(:schedule_id).uniq)
      schedules.each do |schedule|
        if schedule.weekend
          hours[:extra] = (((schedule.end_hour - schedule.start_hour)/1.hour).round) * 2
        else
          hours[:regular] = (((schedule.end_hour - schedule.start_hour)/1.hour).round) * 5
        end
      end
      hours
    end
  
    def postulated(postulates)
      week_hours = []
      weekend_hours = []
      postulates.each do |postulate|
        if postulate.shift.schedule.weekend
          weekend_hours << ((postulate.shift.end_hour - postulate.shift.start_hour)/1.hour).round
        else
          week_hours << ((postulate.shift.end_hour - postulate.shift.start_hour)/1.hour).round
        end
      end
  
      {extra: weekend_hours.sum, regular: week_hours.sum}
    end
  end
end
