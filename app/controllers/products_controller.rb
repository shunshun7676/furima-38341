class ProductsController < ApplicationController
  # ログインしていないユーザーはログインページに促す
  before_action :authenticate_user!, except: [:index, :show]

  def index
   @products = Product.all.order('created_at DESC')
  end

  def new
   @product = Product.new
  end

  def show
  @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
   redirect_to root_path
   else
    render :new
    end
  end

private

def product_params
    params.require(:product).permit(:image, :name, :explanation, :category_id, :status_id, :derively_fee_id, :prefecture_id, :hi_id, :price).merge(user_id: current_user.id)
  end

  def set_product
  @product = Product.find(params[:id])
  end
end