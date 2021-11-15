FactoryBot.define do
  factory :item do
    title            { 'aa' }
    profile          { 'aaa' }
    category_id      { '11' }
    status_id        { '11' }
    delivery_fee_id  { '11' }
    prefecture_id    { '11' } 
    delivery_date_id { '11' }
    price            { '500' }
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample.jpeg'), filename: 'sample.jpeg')
    end
  end
end
