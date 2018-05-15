class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :score
      t.text :message

      t.timestamps
    end
  end
end
