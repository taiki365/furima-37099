class Item < ApplicationRecord
  belongs_to :user
  has_one :buy
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_date
  validates :image, presence: true
  validates :title, presence: true
  validates :profile, presence: true
  validates :category_id, presence: true, numericality: { greater_than: 1 }
  validates :status_id, presence: true, numericality: { greater_than: 1 }
  validates :delivery_fee_id, presence: true, numericality: { greater_than: 1 }
  validates :prefecture_id, presence: true, numericality: { greater_than: 1 }
  validates :delivery_date_id, presence: true, numericality: { greater_than: 1 }
  validates :price, presence: true, format: { with: /\A-?[0-9]+(\.[0-9]+)?\z/ },
                    numericality: { greater_than: 299, less_than: 10_000_000 }
  validates :user, presence: true
end
