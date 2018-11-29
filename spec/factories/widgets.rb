FactoryBot.define do
  # would normally use Faker gem or something similar
  factory :widget do
    name { ('a'..'z').to_a.shuffle[0,8].join }
  end
end
