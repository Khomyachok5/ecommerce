class Picture < ActiveRecord::Base
  belongs_to :product
  validates :image, presence: true
  mount_uploader :image, PictureUploader
end
