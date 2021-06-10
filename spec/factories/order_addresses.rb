FactoryBot.define do
  factory :order_address do
    postal_code               { "000-0000" }
    prefecture_id            { 1 }
    municipality             { "漢字" }
    address                  {"漢字"}
    building                 { '田中' }
    phone_number             { "1234567890"}
  
  end
  end

