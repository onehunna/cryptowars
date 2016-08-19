class IndexValue < ApplicationRecord
  belongs_to :index
  before_validation :calculate, on: :create

  monetize :value_cents
  monetize :value_diff_cents

  validates :value, presence: true

  def calculate
    self.value = index.positions.sum(&:value)
    if last_value = index.values.order(:id).last
      self.value_diff = value - last_value.value
      self.value_diff_percent = ((value / last_value.value) - 1) * 100
    end
  end
end
