FactoryBot.define do
  factory :item do
    name { Faker::Appliance.brand }
    description { Faker::Appliance.equipment }
    unit_price { 1.5 }
    merchant
  end
end
