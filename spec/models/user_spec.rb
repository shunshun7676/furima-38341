require 'rails_helper'

RSpec.describe User, type: :model do
      before do
      @user = FactoryBot.build(:user)
    end

    # ユーザー情報
    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it '全て正しく入力されれば登録できること' do
          expect(@user).to be_valid
    end
  end
      context '新規登録できないとき' do
    it 'nicknameがないと登録できない' do
      @user.nickname = nil
      @user.valid?
      
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスがないと登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性でないと登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは@がない登録できない' do
      @user.email = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードがないと登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードが5文字以下では登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it '全角文字を含むパスワードでは登録できない' do
      @user.password = 'AAAAAA'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'aaaaas'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it 'パスワードは確認用を含めて2回入力しないと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # it "新規登録・ログイン共にエラーハンドリングができていること" do

    # end

    # 本人情報確認
    it '苗字がない場合は登録できない' do
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end

    it '名前がない場合は登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '苗字は英語では入力できない' do
      @user.family_name = 'Kate'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name Full-width characters')
    end

    
    it '苗字カナがない場合は登録できない' do
      @user.family_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end

        it '苗字のフリガナは平仮名は使えない' do
      @user.family_name_kana = 'たなか'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters')
    end

    it '苗字のフリガナは漢字は使えない' do
      @user.family_name_kana = '田中'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters')
    end

    it '苗字のフリガナは英語は使えない' do
      @user.family_name_kana = 'tanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana Full-width katakana characters')
    end

     it '生年月日がないと登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
   end
  end
end
end