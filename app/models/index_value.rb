class IndexValue < ApplicationRecord
  belongs_to :index
  before_validation :calculate, on: :create

  validates :value_usd, presence: true

  def calculate
    self.value_usd = index.positions.sum { |pos| pos.weighted_value }
    if last_value = index.values.order(:id).last
      self.value_diff = value_usd - last_value.value_usd
      self.value_diff_percent = (value_usd / last_value.value_usd) * 100
    end
  end
end
