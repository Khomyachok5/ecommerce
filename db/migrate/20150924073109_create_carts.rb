class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.json :counters
      t.timestamps null: false
    end
  end
end
