require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    it '商品画像が空では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end
    it '商品名が空では出品できない' do
      @item.title = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Title can't be blank"
    end
    it '商品の説明が空では出品できない' do
      @item.profile = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Profile can't be blank"
    end
    it '商品のカテゴリーの情報が空では出品できない' do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end
    it '商品の状態の情報が空では出品できない' do
      @item.status_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Status can't be blank"
    end
    it '商品の配送料負担の情報が空では出品できない' do
      @item.delivery_fee_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Delivery fee can't be blank"
    end
    it '商品の発送元の地域の情報が空では出品できない' do
      @item.prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end
    it '商品の発送まで日数の情報が空では出品できない' do
      @item.delivery_date_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Delivery date can't be blank"
    end
    it '商品の価格情報が空では出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end
    it '商品の価格情報は半角数字で入力されている' do
      @item.price = 'ああ'
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is not a number"
    end
    it '商品の価格が300円以上である' do
      @item.price = '20'
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be greater than 300"
    end
    it '商品の価格が9999999円以下である' do
      @item.price = '10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be less than 9999999"
    end
  end
end