class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :name
      t.date :last_refreshed
      t.boolean :active
      t.string :stock_type

      t.timestamps
    end
  end
end
