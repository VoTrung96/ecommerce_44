class CreateUserSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_suggestions do |t|
      t.references :user, foreign_key: true
      t.string :product_name
      t.text :message

      t.timestamps
    end
  end
end
