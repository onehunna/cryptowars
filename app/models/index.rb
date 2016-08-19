class Index < ApplicationRecord
  BASELINE = 100.to_money('USD')

  belongs_to :user
  has_many :positions, dependent: :delete_all
  has_many :assets, through: :positions
  has_many :values, class_name: 'IndexValue', dependent: :delete_all

  after_create :initialize!

  monetize :value_cents
  monetize :value_diff_cents

  def initialize!
    positions.each(&:initialize!)
    normalize_positions!
    recalculate!
  end

  def normalize_positions!
    # Figure out how much we're missing to sum up to a round 100 dollars.
    remainder = BASELINE - positions.to_a.sum(&:dollars_to_spend)

    return unless remainder.positive?

    # Then add that to one of the posisitions.
    position = positions.sample
    position.dollars_to_spend += remainder
    position.initialize!
  end

  def recalculate!
    calculated_last_value = values.create!
    self.value_diff = calculated_last_value.value_diff
    self.value_diff_percent = calculated_last_value.value_diff_percent
    save!
  end

  def last_value
    values.order(:id).last
  end

  def value
    last_value&.value
  end

  def total_weights
    positions.sum(:weight)
  end

  def codes=(_codes = [])
    _codes.each do |code|
      p = self.positions.new
      p.asset = Asset.find_by(code: code)
      p.weight = 1
    end
  end
end
