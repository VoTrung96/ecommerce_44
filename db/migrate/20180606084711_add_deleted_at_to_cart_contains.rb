class AddDeletedAtToCartContains < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_contains, :deleted_at, :datetime
    add_index :cart_contains, :deleted_at
  end
end
