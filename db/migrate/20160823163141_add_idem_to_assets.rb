class AddIdemToAssets < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :idem, :string
  end
end
