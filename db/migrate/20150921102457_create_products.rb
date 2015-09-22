class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.integer :stock, null: false
      t.boolean :deleted, default: false
      t.string :images, array: true

      t.timestamps null: false
    end
  end
end
