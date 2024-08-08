FactoryBot.define do
  factory :schedule do
    start_hour { "2024-08-06 17:00:00" }
    end_hour { "2024-08-06 23:00:00" }
    duration { 60 }
    weekend { false }
    contract
  end
end
