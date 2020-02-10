FactoryBot.define do
  factory :actor do
    sequence(:dob) { |n| "Some fake dob #{n}" }
    sequence(:name) { |n| "Some fake name #{n}" }
    sequence(:bio) { |n| "Some fake bio #{n}" }
    sequence(:image) { |n| "Some fake image url #{n}" }
  end
end
