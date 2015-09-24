class CreateCartsProducts < ActiveRecord::Migration
  def change
    create_table :carts_products do |t|
      t.belongs_to :cart, index: true
      t.belongs_to :product, index: true
      t.integer :item_count, null: false
      t.timestamps null: false
    end
  end
end
