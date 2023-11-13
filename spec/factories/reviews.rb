FactoryBot.define do
  factory :review do
    association :user
    association :movie
    content { "This is a sample content of the review." }
    contains_spoiler { true }
    rating { 5 }
  end
end
