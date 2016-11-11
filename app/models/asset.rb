class Asset < ApplicationRecord
  has_many :positions
  has_many :indices, through: :positions

  scope :by_importance, -> { where.not(market_cap: nil).order(market_cap: :desc) }

  def self.update_data(data)
    asset = find_by(code: data['symbol'])

    unless asset
      asset = self.new
      asset.code = data['symbol']
      asset.name = data['name']
      asset.idem = data['id']
    end

    old_price = asset.price
    asset.price = data['price_usd']
    asset.market_cap = data['market_cap_usd']

    if asset.price && old_price
      asset.price_diff = asset.price - old_price
      asset.price_diff_percent = ((asset.price / old_price) - 1) * 100
    end

    asset.save!
  end
end
