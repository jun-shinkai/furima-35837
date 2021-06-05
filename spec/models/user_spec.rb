require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが必須であること' do
       @user.nickname =''
       @user.valid?
       expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'メールアドレスが必須であること' do
      @user.email =''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'メールアドレスは、@を含む必要があること。' do
      @user.email="ssssss"
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end
    it 'パスワードが必須であること' do
      @user.password=''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password='aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password='gfgdgrrtg'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password には英字と数字の両方を含めて設定してください"
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '本人情報確認' do
    it 'お名前(全角)は、名字と名前がそれぞれ必須であること。'do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
      @user.last_name ='444444'
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname is invalid. Input full-width characters."
    end
    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること。' do
      @user.last_name_kana  = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。'do
    @user.last_name_kana = "5464"
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname is invalid. Input full-width characters."
    end
    it '生年月日が必須であること。'do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end

  end  
end   

