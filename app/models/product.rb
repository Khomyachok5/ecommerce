class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :category
  has_many :pictures
  validates :title, :description, :price, :stock, presence: true
  validates :title, uniqueness: {message: "A product with this name already exists"}, length: {minimum: 2, maximum: 100}
end
