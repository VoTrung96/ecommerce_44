class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.text :summary
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
