namespace :shift do
  desc "Generate shifts for each week."
  task generate_shifts: :environment do
    ActiveRecord::Base.transaction do
      Company.all.each do |company|
        company.contracts.each do |contract|
          contract.schedules.order(weekend: :asc).each do |schedule|
            week = Time.now.utc.strftime('%U')
            if schedule.weekend
              days_for_saturday = (6 - (Time.now.utc.wday + 7)) % 7
              start = Time.now.utc.advance(days: days_for_saturday, weeks: 1)
              2.times do |i|
                start = start.change(hour: schedule.start_hour.hour)
                while(start.hour < schedule.end_hour.hour)
                  Shift.create(start_hour: start, end_hour: start.advance(minutes: schedule.duration), week: week, schedule_id: schedule.id, company_id: company.id)
                  start = start.advance(minutes: schedule.duration)
                end
                start = start.advance(days: 1)
              end
            else
              days_for_monday = (1 - (Time.now.utc.wday + 7)) % 7
              start = Time.now.utc.advance(days: days_for_monday)
              5.times do |i|
                start = start.change(hour: schedule.start_hour.hour)
                
                while(start.hour < schedule.end_hour.hour)
                  Shift.create(start_hour: start, end_hour: start.advance(minutes: schedule.duration), week: week, schedule_id: schedule.id, company_id: company.id)
                  start = start.advance(minutes: schedule.duration)
                end
                start = start.advance(days: 1)
              end
            end
          end
        end
      end
    end
  end
end
