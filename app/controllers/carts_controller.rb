class CartsController < ApplicationController
  before_filter :initialize_cart

  def add_to_cart
    @cart = initialize_cart
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
    @products = initialize_cart.carts_products
  end

  def remove_from_cart
  end

end
