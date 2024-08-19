FactoryBot.define do
  factory :shift do
    start_hour { "2024-08-14 17:00:00" }
    end_hour { "2024-08-14 18:00:00" }
    week { "32" }
    schedule
    company
  end
end
