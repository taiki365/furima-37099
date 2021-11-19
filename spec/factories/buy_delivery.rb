FactoryBot.define do
  factory :buy_delivery do
    zip_code         { '123-4567' }
    prefecture_id    { '3' }
    city             { '11' }
    address          { '11' }
    building_name    { '11' }
    telephone_number { '1234567891' }
  end
end
