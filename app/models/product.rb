class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  searchable do
    text :title, :description
    integer :category_id
  end

  belongs_to :category
  has_many :pictures
  accepts_nested_attributes_for :pictures
  validates :title, :description, :price, :stock, presence: true
  validates :title, uniqueness: {message: "A product with this name already exists"}, length: {minimum: 2, maximum: 100}
end
