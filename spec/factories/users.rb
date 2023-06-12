FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { name.split(' ').join('-').downcase.to_s + "@#{Faker::Internet.domain_name}" }
    fractal_id { rand(1_000..9_999) }
  end
end
