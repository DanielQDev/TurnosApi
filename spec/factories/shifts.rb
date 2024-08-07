FactoryBot.define do
  factory :shift do
    start_hour { "2024-08-06 10:15:52" }
    end_hour { "2024-08-06 10:15:52" }
    is_confirmed { false }
    user { nil }
    schedule { nil }
    company { nil }
  end
end
