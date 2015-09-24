class CreateOrdersProducts < ActiveRecord::Migration
  def change
    create_table :orders_products do |t|
      t.integer :item_count, null: false
      t.belongs_to :product, index: true
      t.belongs_to :order, index: true
      t.decimal :item_price, null: false
      
      t.timestamps null: false
    end
  end
end
