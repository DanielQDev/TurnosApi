FactoryBot.define do
  factory :user do
    email {'test@email.com'}
    first_name {'jonh'}
    last_name {'doe'}
    password {'12345abc'}
    role {'admin'}
    color {'#f1f1f1'}
  end
end