class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :quantity, default: 0
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
