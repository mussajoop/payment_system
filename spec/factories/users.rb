FactoryBot.define do
  factory :user do
    description { Faker::Quote.famous_last_words }
    email { Faker::Internet.safe_email }
    password { "passer123" }
    name { Faker::Name.name }
  end
end
