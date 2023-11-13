FactoryBot.define do
  factory :comment do
    association :user
    association :review
    content { "This is sample content of the comment" }
  end
end
