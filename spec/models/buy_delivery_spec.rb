require 'rails_helper'

RSpec.describe BuyDelivery, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @buy_delivery = FactoryBot.build(:buy_delivery, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end
    context '商品が購入、配送出来ない場合' do
      it '郵便番号が空では配送出来ない' do
        @buy_delivery.zip_code = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "Zip code can't be blank"
      end
      it '市区町村情報が空では配送出来ない' do
        @buy_delivery.city = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "City can't be blank"
      end
      it '番地情報が空では配送出来ない' do
        @buy_delivery.address = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "Address can't be blank"
      end
      it '電話番号が空では配送出来ない' do
        @buy_delivery.telephone_number = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "Telephone number can't be blank", 'Telephone number is invalid'
      end
      it '郵便番号は「○○○-○○○○」の半角数字のみ配送出来る' do
        @buy_delivery.zip_code = '123-abcd'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Zip code is invalid'
      end
      it '郵便番号は「○○○-○○○○」の7桁のみ配送出来る' do
        @buy_delivery.zip_code = '123-ab'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Zip code is invalid'
      end
      it '郵便番号は「-」が含まれていなければ配送出来ない' do
        @buy_delivery.zip_code = '12'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Zip code is invalid'
      end
      it '電話番号が9桁以下では購入出来ない' do
        @buy_delivery.telephone_number = '11'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Telephone number is invalid'
      end
      it '電話番号は12桁以上では購入出来ない' do
        @buy_delivery.telephone_number = '123456789123'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Telephone number is invalid'
      end
      it '電話番号は半角数字のみ配送出来る' do
        @buy_delivery.telephone_number = 'ああ'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Telephone number is invalid'
      end
      it '都道府県情報に「---」が選択されている場合は出品できない' do
        @buy_delivery.prefecture_id = 1
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture  must be greater than 2'
      end
      it 'userが紐付いていなければ出品できない' do
        @buy_delivery.user_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "User can't be blank"
      end
      it 'tokenが空では購入出来ない' do
        @buy_delivery.token = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "Token can't be blank"
      end
      it 'itemが紐付いていなければ出品できない' do
        @buy_delivery.item_id = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include "Item can't be blank"
      end
    end
    context '商品が購入、配送出来る場合' do
      it '全ての項目が入力されていれば購入出来る' do
        expect(@buy_delivery).to be_valid
      end
      it '建物名が空でも購入出来る' do
        @buy_delivery.building_name = ''
        @buy_delivery.valid?
        expect(@buy_delivery).to be_valid
      end
    end
  end
end
