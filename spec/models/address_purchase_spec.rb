require 'rails_helper'

RSpec.describe AddressPurchase, type: :model do
  before do
    @product = FactoryBot.create(:product)
    @user = FactoryBot.create(:user)
    @address_purchase = FactoryBot.build(:address_purchase, user_id: @user.id, product_id: @product.id)
    sleep (1)
  end

  describe '商品購入情報の保存' do
    context '商品購入情報の保存' do
      it 'すべてのフォームの入力がされている' do
        expect(@address_purchase).to be_valid
      end
      it "tokenがあれば保存ができること" do
        expect(@address_purchase).to be_valid
      end
      it "建物名が空の場合でも保存できること" do
        @address_purchase.building_name = ''
        @address_purchase.valid?
        expect(@address_purchase).to be_valid
      end
    end

    context '商品を購入できないとき' do
      it 'postal_code が空では登録できないこと' do
        @address_purchase.postal_code = ''
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_code が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @address_purchase.postal_code = '123ー4567'
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが 1 では保存できないこと' do
        @address_purchase.prefecture_id = 1
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'municipality が空では保存できないこと' do
        @address_purchase.municipality = ''
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'address が空では保存できないこと' do
        @address_purchase.address = ''
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_number が空では保存できないこと' do
        @address_purchase.phone_number = ''
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_number が英数混合では保存できないこと' do
        @address_purchase.phone_number = '0000000aaa'
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Phone number is not a number")
      end
      it 'phone_numberは9桁以下の数値では登録できないこと' do
        @address_purchase.phone_number = '090123456'
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは12桁以上の数値では登録できないこと' do
        @address_purchase.phone_number = '090123456789'
        @address_purchase.valid?  
        expect(@address_purchase.errors.full_messages).to include('Phone number is invalid')
      end
        it "token が空では登録できないこと" do
        @address_purchase.token = nil
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Token can't be blank")
      end
      it "user_id が空では登録できないこと" do
        @address_purchase.user_id = nil
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("User can't be blank")
      end
      it "product_id が空では登録できないこと" do
        @address_purchase.product_id = nil
        @address_purchase.valid?
        expect(@address_purchase.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end