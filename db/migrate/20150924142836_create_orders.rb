class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :cart
      t.string :customer
      t.string :shipping_address
      t.string :email
      t.string :phone
      t.decimal :total

      t.timestamps null: false
    end
  end
end
