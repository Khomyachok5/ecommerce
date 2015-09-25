class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @value = total_c(session[:cart_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.cart_id = current_cart.id
    set_total(@order)
    if check_stock(@order) == true
      if @order.save
        decrement_stock
        empty_cart
        redirect_to order_path(@order.id), notice: 'Order was successfully created.' 
      else
        render :new 
      end
    else
      flash.alert = "Purchased quantity exceeds stock"
      @order.destroy
      redirect_to cart_path
    end
  end



  private
    def set_order
      @order = Order.find(params[:id])
    end

    def decrement_stock
      current_cart.line_items.each do |li|
        stock = li.product.stock - li.item_count
        li.product.update_attributes(stock: stock)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer, :shipping_address, :email, :phone, :total, :cart_id, :id)
    end

    def total_c(cart_id)
      total = []
      Cart.find(cart_id).line_items.each do |line_item|
        product_price = line_item.product.price
        quantity = line_item.item_count
        line_item_price = product_price * quantity
        total << line_item_price
      end
      order_value = total.inject(:+)
    end

    def set_total(order)
      order.update_attributes(total: total_c(current_cart.id))
    end

    def empty_cart
      session.delete(:cart_id)
    end

    def current_cart
      Cart.find(session[:cart_id])
    end

    def check_stock(order)
      order.cart.line_items.each do |l|
        return false if l.item_count > l.product.stock
      end
      true
    end
  end

