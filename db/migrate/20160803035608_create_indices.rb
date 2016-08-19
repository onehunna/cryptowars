class CreateIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :indices do |t|
      t.integer :user_id
      t.string :name
      t.monetize :value
      t.monetize :value_diff, default: 0
      t.decimal :value_diff_percent, default: 0
      t.integer :rank, default: 0

      t.timestamps
    end
    add_index :indices, :user_id
  end
end
