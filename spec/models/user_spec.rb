require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    sleep 0.1
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
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'メールアドレスは、@が存在しなければ登録できない。' do
        @user.email = 'ssssss'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end
      it '同じメールアドレスでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'パスワードは5文字以下だと登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'パスワードは英語のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードには英字と数字の両方を含めて設定してください"
      end
      it 'パスワードは、半角英数字混合での入力でなければ登録できない' do
        @user.password = 'あいうえおか'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードには英字と数字の両方を含めて設定してください"
      end
      it 'パスワードは、数字でのみでは登録できない' do
        @user.password = '4444444'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードには英字と数字の両方を含めて設定してください"
      end
      it 'パスワードとパスワード（確認）は、値が一致しなければ登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameがなければ登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字を入力してください"
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと保存できない' do
        @user.last_name = 'fewfwef'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字は日本語で記入してください"
      end
      it 'first_nameがなければ登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと保存できない' do
        @user.first_name = 'fdgvddf'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は日本語で記入してください"
      end
      it 'last_name_kanaがなければ登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字(カナ)を入力してください"
      end
      it 'last_name_kanaは全角（カタカナ）でないと保存できない' do
        @user.last_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字(カナ)は日本語(カナ)で記入してください"
      end
      it 'first_name_kanaがなければ登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前(カナ)を入力してください"
      end
      it 'first_name_kanaは全角（カタカナ）でないと保存できない' do
        @user.first_name_kana = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前(カナ)は日本語(カナ)で記入してください"
      end
      it 'birst_dateがなければ登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end
end
