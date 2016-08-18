class Asset < ApplicationRecord
  MAX_VALUES = 5

  has_many :values, class_name: 'AssetValue', dependent: :delete_all
  has_many :positions
  has_many :indices, through: :positions

  def price
    return 0 unless values.any?
    values.order(:id).last.price
  end

  def self.update_data(data)
    asset = find_by(code: data['symbol'])

    unless asset
      asset = self.new
      asset.code = data['symbol']
      asset.name = data['name']
      asset.save!
    end

    # Keep only a certain max historical values for asset
    if asset.values.count > MAX_VALUES
      asset.values.order(:id).last.destroy
    end

    value = asset.values.new
    value.price = data['price_usd']
    value.market_cap = data['market_cap_usd']
    value.save!
  end
end
