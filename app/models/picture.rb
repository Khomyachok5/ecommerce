class Picture < ActiveRecord::Base
  belongs_to :product
  validates :image, presence: true
end
