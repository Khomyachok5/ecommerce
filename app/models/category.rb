class Category < ActiveRecord::Base
  has_many :products
  validates :title, presence: true
  validates :title, uniqueness: {message: "A category with this name already exists"}
end
