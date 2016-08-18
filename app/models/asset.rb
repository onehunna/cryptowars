class Asset < ApplicationRecord
  MAX_VALUES = 5

  has_many :values, class_name: 'AssetValue'
  has_many :positions
  has_many :indices, through: :positions

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
    value.price_usd = data['price_usd']
    value.price_btc = data['price_btc']
    value.market_cap_usd = data['market_cap_usd']
    value.save!
  end
end
