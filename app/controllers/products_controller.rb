class ProductsController < ApplicationController
  # ログインしていないユーザーはログインページに促す
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update,:destroy ]
  
  def index
   @products = Product.all.order('created_at DESC')
  end

  def new
   @product = Product.new
  end

  def show
  end

  def edit
    unless @product.user_id == current_user.id 
      redirect_to root_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
   redirect_to root_path
   else
    render :new
    end
  end

def destroy
  if current_user.id == @product.user_id
    @product.destroy
   end
  redirect_to root_path
  end


private

def product_params
 params.require(:product).permit(:image, :name, :explanation, :category_id, :status_id, :derively_fee_id, :prefecture_id, :hi_id, :price).merge(user_id: current_user.id)
  end

  def set_product
  @product = Product.find(params[:id])
  end
end