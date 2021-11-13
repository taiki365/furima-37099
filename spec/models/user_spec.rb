require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it 'ニックネームが空では登録出来ない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'メールアドレスが空では登録出来ない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'パスワードが空では登録出来ない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'メールアドレスが既に登録されている' do
      @user.save
      another_user = FactoryBot.create(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'パスワードが6文字以上ではない' do
      user = FactoryBot.build(:user)
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end
    it 'パスワードが確認と一致しない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'メールアドレスに@が含まれていない' do
      @user.email = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end
    it 'パスワードが半角英数字混合ではない' do
      @user.password = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is invalid'
    end
    it '名前(全角)の苗字が空では登録出来ない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank", 'Last name is invalid'
    end
    it '名前(全角)の名前が空では登録出来ない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank", 'First name is invalid'
    end
    it '名前(全角)の苗字は全角での入力されている' do
      @user.last_name = 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name is invalid'
    end
    it '名前(全角)の名前は全角での入力されている' do
      @user.first_name = 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name is invalid'
    end
    it '名前(カナ)は苗字が空では登録出来ない' do
      @user.kana_last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Kana last name can't be blank", 'Kana last name is invalid'
    end
    it '名前(カナ)は名前が空では登録出来ない' do
      @user.kana_first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Kana first name can't be blank", 'Kana first name is invalid'
    end
    it '名前(カナ)の苗字は全角カタカナで入力されている' do
      @user.kana_last_name = 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Kana last name is invalid'
    end
    it '名前(カナ)の名前は全角カタカナで入力されている' do
      @user.kana_first_name = 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Kana first name is invalid'
    end
    it '生年月日が空では登録出来ない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end
  end
end
