FactoryBot.define do
  factory :movie do
    association :user
    sequence(:title) { |n| "Movie Title #{n}" }
    synopsis { "This is a sample synopsis of the movie." }
    thumbnail { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/sample.jpg')) }
    screening_time { 120 }
    text_color { "黒" }
    text_size { "中" }
    text_position { "上部" }

    after(:build) do |movie|
      movie.categories << FactoryBot.create(:category)
    end
  end
end