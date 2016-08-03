class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.string :code
      t.string :name

      t.timestamps
    end

    add_index :assets, :code, unique: true
  end
end
