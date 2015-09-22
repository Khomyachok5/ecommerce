class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @product_listing = Product.order(created_at: :asc)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      params[:pictures][:image].each do |i|
         @product.pictures.create!(image: i, product_id: @product.id)
      end
      redirect_to product_path(@product)
    else
      flash.alert = @product.errors.full_messages.join('. ')
      redirect_to new_product_path
    end
  end

  def show
    @images = @product.pictures.all
  end

  def edit
  end

  def update
    @product.update_attributes(product_params)
    redirect_to product_path(@product)
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :stock, :slug, image_attributes: [:id, :product_id, :image])
  end

  def find_product
    @product = Product.friendly.find(params[:id])
  end
end
