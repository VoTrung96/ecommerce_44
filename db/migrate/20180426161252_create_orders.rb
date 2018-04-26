class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.text :delivery_address
      t.string :phone_number
      t.float :grand_total, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
