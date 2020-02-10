FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Some fake title #{n}" }
    sequence(:year) { |n| 9.year.ago.year }
    sequence(:duration) { |n| n }
    sequence(:description) { |n| "Some fake description #{n}" }
    sequence(:image) { |n| "Some fake image url #{n}" }
  end
end
