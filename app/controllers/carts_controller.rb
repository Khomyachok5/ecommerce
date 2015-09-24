class CartsController < ApplicationController
  before_action :initialize_cart

  def add_to_cart
    product = Product.find(params[:product_id])
    @cart_product = @cart.carts_products.build(product: product, item_count: 1)
    if @cart_product.save
      flash.notice = "The product has been successfully added to cart"
    else
      flash.alert = @cart_product.errors.full_messages.join('. ')
    end
    redirect_to :back
  end

  def view_cart
    @products = @cart.carts_products
  end

  def remove_from_cart
    @cart.carts_products.where(id: params[:item_id]).first.destroy
    redirect_to cart_path
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
