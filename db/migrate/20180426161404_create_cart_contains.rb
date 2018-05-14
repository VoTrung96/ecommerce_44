class CreateCartContains < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_contains do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
