# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[
  {
    email: "user1@email.com",
    first_name: "user 1",
    last_name: "doe",
    password: "12345678",
    color: "#f1f1f1"
  },
  {
    email: "user2@email.com",
    first_name: "user 2",
    last_name: "doe",
    password: "12345678",
    color: "#f1f134"
  },
  {
    email: "user3@email.com",
    first_name: "user 3",
    last_name: "doe",
    password: "12345678",
    role: "admin",
    color: "#f1d3f1"
  }
].each{|user| User.new(user).save}

[
  {
    name: "Laboratorios",
    service: "monitoring"
  },
  {
    name: "Acme Labs",
    service: "monitoring"
  }
].each{|company| Company.new(company).save}

Company.all.each do |company|
  Contract.create(start_date: Time.now, end_date: Time.now.advance(years: 1), status: "active", company_id: company.id)
end

Contract.all.each do |contract|
  Schedule.create(start_hour: '17:00', end_hour: '23:00', duration: 60, weekend: false, contract_id: contract.id)
  Schedule.create(start_hour: '10:00', end_hour: '23:00', duration: 60, weekend: true, contract_id: contract.id)
end

User.all.each do |user|
  Company.all.each do |company|
    puts "#{company.name}"
    company.contracts.each do |contract|
      contract.schedules.each do |schedule|
        if schedule.weekend
          days_for_saturday = (6 - (Time.now.wday + 7)) % 7
          start = Time.now.advance(days: days_for_saturday)
          2.times do |i|
            start = start.change(hour: schedule.start_hour.hour)
            
            while(start.hour < schedule.end_hour.hour)
              Shift.create(start_hour: start, end_hour: start.advance(minutes: schedule.duration), week: start.strftime('%U'), user_id: user.id, schedule_id: schedule.id, company_id: company.id)
              start = Shift.last.end_hour
            end
            start = start.advance(days: 1)
          end
        else
          days_for_monday = (1 - (Time.now.wday + 7)) % 7
          start = Time.now.advance(days: days_for_monday)
          5.times do |i|
            start = start.change(hour: schedule.start_hour.hour)
            
            while(start.hour < schedule.end_hour.hour)
              Shift.create(start_hour: start, end_hour: start.advance(minutes: schedule.duration), week: start.strftime('%U'), user_id: user.id, schedule_id: schedule.id, company_id: company.id)
              start = Shift.last.end_hour
            end
            start = start.advance(days: 1)
          end
        end
      end
    end
  end
end
