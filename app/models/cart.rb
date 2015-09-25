class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :products, through: :line_items

  def add(product)
    if existing = line_items.find_by(product_id: product.id)
      existing.item_count += 1
      existing.save!
    else
      self.line_items.create(product_id: product.id)
    end
  end

  def remove(product)
    if existing = line_items.find_by(product_id: product.id)
      existing.item_count -= 1
      existing.item_count > 0 ? existing.save : existing.destroy
    end
  end
end
