class Order < ActiveRecord::Base
  has_one :cart

  #after_commit :set_total


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



end
