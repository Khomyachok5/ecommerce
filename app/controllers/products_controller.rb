class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit]
  
  def index
    @product_listing = Product.order(created_at: :asc)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      flash.alert = @product.errors.full_messages.join('. ')
      redirect_to new_product_path
    end
  end

  def show
  end

  def edit
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :stock)
  end

  def find_product
    @product = Product.friendly.find(params[:id])
  end
end
