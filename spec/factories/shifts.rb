FactoryBot.define do
  factory :shift do
    start_hour { "2024-08-06 17:00:00" }
    end_hour { "2024-08-06 18:00:00" }
    is_confirmed { false }
    is_postulated { false }
    week { 31 }
    user
    schedule
    company
  end
end
