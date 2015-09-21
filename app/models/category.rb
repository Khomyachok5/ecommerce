class Category < ActiveRecord::Base
  has_many :products
  belongs_to :parent_category, class_name: "Category"
  has_many :subcategories, class_name: "Category", foreign_key: "parent_category_id"
  validates :title, presence: true
  validates :title, uniqueness: {message: "A category with this name already exists"}
end
