class Position < ApplicationRecord
  belongs_to :index
  belongs_to :asset

  def weight
    size / index.total_weights
  end

  def weighted_value
    asset.price * weight
  end
end
