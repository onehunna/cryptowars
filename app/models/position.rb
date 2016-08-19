class Position < ApplicationRecord
  belongs_to :index
  belongs_to :asset

  def initialize!
    # Calculate how much of the asset we need to buy to satisfy the weight
    self.size = dollars_to_spend / asset.price
    save!
  end

  def dollars_to_spend
    relative_weight * Index::BASELINE
  end

  def relative_weight
    weight / index.total_weights
  end

  def value
    asset.price * size
  end
end
