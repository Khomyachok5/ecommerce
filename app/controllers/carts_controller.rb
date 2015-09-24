class CartsController < ApplicationController
  before_action :initialize_cart

  def add_to_cart

    product = Product.find(params[:product_id])
    @cart.add(product)
    redirect_to :back
  end

  def view_cart
    @products = @cart.products
  end

  def remove_from_cart
    product = Product.find(params[:item_id])
    @cart.remove(product)
    redirect_to :back
  end

  private

  def initialize_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

end
