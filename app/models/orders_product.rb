class OrdersProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :item_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  def product_price
    unit_price * quantity
  end

end
