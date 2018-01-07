class CreateStockInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_infos do |t|
      t.references :stock, foreign_key: true
      t.date :stock_date
      t.decimal :open, precision: 12, scale: 4
      t.decimal :high, precision: 12, scale: 4
      t.decimal :low, precision: 12, scale: 4
      t.decimal :close, precision: 12, scale: 4
      t.decimal :adj_close, precision: 12, scale: 4
      t.integer :volume

      t.timestamps
    end
  end
end
