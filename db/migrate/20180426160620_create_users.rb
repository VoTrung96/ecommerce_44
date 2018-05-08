class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :address
      t.integer :phone_number
      t.string :password_digest
      t.integer :role, default: 0

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
