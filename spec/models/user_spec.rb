require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it 'ユーザーの情報が正常であれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスは、@が存在しなければ登録できない。' do
        @user.email = 'ssssss'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it '同じメールアドレスでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは5文字以下だと登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードは英語のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードは、半角英数字混合での入力でなければ登録できない' do
        @user.password = 'あいうえおか'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードは、数字でのみでは登録できない' do
        @user.password = '4444444'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードとパスワード（確認）は、値が一致しなければ登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameがなければ登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと保存できない' do
        @user.last_name = 'fewfwef'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid. Input full-width characters.'
      end
      it 'first_nameがなければ登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと保存できない' do
        @user.first_name = 'fdgvddf'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid. Input full-width characters.'
      end
      it 'last_name_kanaがなければ登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it 'last_name_kanaは全角（カタカナ）でないと保存できない' do
        @user.last_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana is invalid. Input full-width katakana characters.'
      end
      it 'first_name_kanaがなければ登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it 'first_name_kanaは全角（カタカナ）でないと保存できない' do
        @user.first_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana is invalid. Input full-width katakana characters.'
      end
      it 'birst_dateがなければ登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
    end
  end
end
