FactoryBot.define do
  factory :contract do
    start_date { "2024-08-05 22:56:00" }
    end_date { "2025-08-05 22:56:00" }
    status { "active" }
    company
  end
end
