class CreateIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :indices do |t|
      t.integer :user_id
      t.string :name
      t.decimal :value_usd
      t.decimal :value_diff_1h
      t.decimal :value_diff_24h
      t.decimal :value_diff_7d
      t.integer :rank

      t.timestamps
    end
    add_index :indices, :user_id
  end
end
