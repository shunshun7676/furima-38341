class AddressPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number, :purchase, :token

  with_options presence: true do
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id
  validates :municipality
  validates :address
  validates :phone_number,format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
  validates :user_id
  validates :product_id
  validates :token
 end

 with_options numericality: { other_than: 0 } do
   validates  :prefecture_id
 end

 def save
   purchase = Purchase.create(user_id: user_id, product_id: product_id)
   Address.create(postal_code: postal_code,  prefecture_id:  prefecture_id, municipality: municipality, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
 end
end