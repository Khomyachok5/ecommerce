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
    #@order = Order.new
    @value = total_c(session[:cart_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
      if @order.save
        set_total(@order)
        decrement_stock
        redirect_to order_path(@order.id), notice: 'Order was successfully created.' 

      else
        render :new 
      end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def decrement_stock
    #product_price = line_item.product.price
    @cart = Cart.find(session[:cart_id])
      @cart.line_items.each do |li|
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
      @cart = Cart.find(session[:cart_id])
      order.update_attributes(total: total_c(@cart))
    end
end
