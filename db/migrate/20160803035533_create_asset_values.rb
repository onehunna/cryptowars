class CreateAssetValues < ActiveRecord::Migration[5.0]
  def change
    create_table :asset_values do |t|
      t.integer :asset_id
      t.decimal :price_usd
      t.decimal :price_btc
      t.decimal :market_cap_usd
      t.decimal :price_diff
      t.decimal :price_diff_percent

      t.timestamps
    end
    add_index :asset_values, :asset_id
  end
end
