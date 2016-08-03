class CreateUserIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :user_identities do |t|
      t.string :provider
      t.string :email
      t.string :provider_user_id
      t.string :user_id
      t.string :username
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end

    add_index :user_identities, :provider_user_id
    add_index :user_identities, :user_id
    add_index :user_identities, [:provider, :provider_user_id], unique: true
  end
end
