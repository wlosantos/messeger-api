FactoryBot.define do
  factory :app do
    name { Faker::App.name }
    app_id { rand(1...999) }
  end
end
