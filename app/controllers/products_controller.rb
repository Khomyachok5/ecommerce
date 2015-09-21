class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  def index
    @product_listing = Product.order(created_at: :asc)
  end

  def show
  end

  private

  def find_product
    @product = Product.friendly.find(params[:id])
  end
end
