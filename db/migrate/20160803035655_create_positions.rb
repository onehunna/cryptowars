class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.integer :asset_id
      t.integer :index_id
      t.decimal :weight, default: 1
      t.decimal :relative_weight
      t.decimal :dollars_to_spend
      t.decimal :size
      t.decimal :value_at_purchase
      t.decimal :price_at_purchase

      t.timestamps
    end

    add_index :positions, :index_id
    add_index :positions, [:asset_id, :index_id], unique: true
  end
end
