FactoryBot.define do
  factory :item do
    name                     { Faker::Games::SuperMario.character }
    info                     { 'gergregreg' }
    category_id               { 1 }
    sales_status_id           { 1 }
    shipping_fee_status_id    { 1 }
    prefecture_id             { 1 }
    scheduled_delivery_id     { 1 }
    price                     { 333 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user
  end
end
