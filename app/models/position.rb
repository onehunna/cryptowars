class Position < ApplicationRecord
  belongs_to :index
  belongs_to :asset

  def initialize!
    self.relative_weight ||= weight / index.total_weights
    self.dollars_to_spend ||= relative_weight * Index::BASELINE

    # Calculate how much of the asset we need to buy to satisfy the weight
    self.size = dollars_to_spend / asset.price
    save!
  end

  def value
    asset.price * size
  end
end
