class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.string :code
      t.string :name
      t.decimal :price
      t.decimal :market_cap
      t.decimal :price_diff, default: 0
      t.decimal :price_diff_percent, default: 0

      t.timestamps
    end

    add_index :assets, :code, unique: true
  end
end
