FactoryBot.define do

  factory :order do
    shipped_at { Time.now+rand(10000) }
  end

  trait :unshipped do
    shipped_at { nil }
  end
end
