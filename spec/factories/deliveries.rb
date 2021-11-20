FactoryBot.define do
  factory :delivery do
    zip_code         { 'aa' }
    prefecture_id    { 'aaa' }
    city             { '11' }
    address          { '11' }
    building_name    { '11' }
    telephone_number { '11' }
    association :buy
  end
end
