class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :remember_created_at
      t.string :remember_token
      t.string :avatar_url

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :remember_token
  end
end
