class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :cart, index: true
      t.belongs_to :product, index: true
      t.integer :item_count, null: false, default: 1
      t.timestamps null: false
    end
  end
end
