class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit]
  
  def index
    @product_listing = Product.order(created_at: :asc)
  end

  def show
  end

  def edit
  end

  private

  def find_product
    @product = Product.friendly.find(params[:id])
  end
end
