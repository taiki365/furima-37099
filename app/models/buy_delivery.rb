class BuyDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :token, :buy_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :zip_code
    validates :city
    validates :address
    validates :telephone_number
  end
  validates :prefecture_id, numericality: { other_than: 1, message: ' must be greater than 2' }
  validates :zip_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Delivery.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name,
                    telephone_number: telephone_number, buy_id: buy.id)
  end
end
