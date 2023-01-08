class PurchasesController < ApplicationController
 before_action :set_product, only: [:index, :create]
 before_action :authenticate_user!
 

 def index
   if @product[:user_id] == current_user.id || @product.purchase.present?
     redirect_to root_path
   else
     @purchase = AddressPurchase.new
   end
 end

 def create
   @purchase = AddressPurchase.new(purchase_params)
   if @purchase.valid?
     pay_item
     @purchase.save
     redirect_to root_path
   else
     render :index
   end
 end

 private

 def purchase_params
   params.require(:address_purchase).permit(:postal_code, :prefecture_id, :municipality, :building_name, :address, :phone_number).merge(user_id: current_user.id, product_id: params[:product_id], token: params[:token])
 end

 def pay_item
   Payjp.api_key = ENV['PAYJP_SECRET_KEY']
   Payjp::Charge.create(
     amount: @product.price,
     card: params[:token],
     currency: 'jpy'
   )
 end

 def set_product
   @product = Product.find(params[:product_id])
 end

 
end