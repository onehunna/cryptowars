class Position < ApplicationRecord
  belongs_to :index
  belongs_to :asset

  def initialize!
    self.relative_weight ||= weight / index.total_weights
    self.dollars_to_spend ||= relative_weight * Index::BASELINE

    # Calculate how much of the asset we need to buy to satisfy the weight
    self.size = dollars_to_spend / asset.price

    # Store initial prices for comparison later
    self.value_at_purchase = value
    self.price_at_purchase = asset.price

    save!
  end

  def value_diff
    asset.price_diff * size
  end

  def value
    asset.price * size
  end
end
