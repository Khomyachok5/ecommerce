class Order < ActiveRecord::Base
  belongs_to :cart
  validates :customer, :shipping_address, :email, presence: true
  #TODO: 
  #validates :total, presence: true, numericality: { only_integer: false, greater_than: 0 }
end
