class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :products
  belongs_to :parent_category, class_name: "Category"
  has_many :subcategories, class_name: "Category", foreign_key: "parent_category_id"
  validates :title, presence: true
  validates :title, uniqueness: {message: "A category with this name already exists"}

  def update_products(category_id)
    self.products.each do |p|
      p.update_attributes(category_id: (category_id.present? ? category_id : nil))
    end
  end
end
