class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.string :code
      t.string :name
      t.decimal :market_cap, precision: 14, scale: 2
      t.monetize :price
      t.monetize :price_diff, default: 0
      t.decimal :price_diff_percent, default: 0

      t.timestamps
    end

    add_index :assets, :code, unique: true
  end
end
