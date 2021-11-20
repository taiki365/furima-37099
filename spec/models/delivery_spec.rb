require 'rails_helper'

RSpec.describe Delivery, type: :model do
  before do
    @buy_delivery = FactoryBot.build(:delivery)
  end
  describe '商品配送先情報機能' do
    context '商品が配送出来ない場合' do
      it '郵便番号が空では配送出来ない' do
        @buy_delivery.zip_code = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '都道府県情報が空では配送出来ない' do
        @buy_delivery.prefecture_id = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '市区町村情報が空では配送出来ない' do
        @buy_delivery.city = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '番地情報が空では配送出来ない' do
        @buy_delivery.address = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '建物名が空では配送出来ない' do
        @buy_delivery.building_name = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '電話番号が空では配送出来ない' do
        @buy_delivery.telephone_number = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '郵便番号は「○○○-○○○○」の半角数字のみ配送出来る' do
        @buy_delivery.zip_code = '123-4567'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '電話番号は10桁以上11桁以内の半角数字のみ配送出来る' do
        @buy_delivery.zip_code = '1111111111'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
      it '都道府県情報に「---」が選択されている場合は出品できない' do
        @buy_delivery.prefecture_id = 1
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include 'Prefecture must be greater than 2'
      end
    end
    context '商品が配送出来る場合' do
      it '全ての項目が入力されていれば購入出来る' do
        expect(@buy_delivery).to be_valid
      end
    end
  end
end
