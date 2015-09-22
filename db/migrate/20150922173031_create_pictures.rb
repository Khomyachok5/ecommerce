class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :product, index: true
      t.string :image
      t.timestamps null: false
    end
  end
end