class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product

  validates :item_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
end