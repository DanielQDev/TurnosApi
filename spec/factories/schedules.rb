FactoryBot.define do
  factory :schedule do
    start_hour { "2024-08-06 09:12:06" }
    end_hour { "2024-08-06 09:12:06" }
    duration { 1 }
    weekend { false }
    contract { nil }
  end
end
