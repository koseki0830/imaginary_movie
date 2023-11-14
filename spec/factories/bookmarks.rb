FactoryBot.define do
  factory :bookmark do
    association :user
    association :movie
  end
end
