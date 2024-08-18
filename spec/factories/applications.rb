FactoryBot.define do
  factory :application do
    is_confirmed { false }
    user { nil }
    shift { nil }
  end
end
