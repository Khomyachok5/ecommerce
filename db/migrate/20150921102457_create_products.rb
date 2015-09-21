class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock
      t.boolean :deleted, default: false

      t.timestamps null: false
    end
  end
end
