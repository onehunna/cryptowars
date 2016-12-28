class Index < ApplicationRecord
  BASELINE = 100
  MAX_INDICES_PER_USER = 5

  belongs_to :user
  has_many :positions, dependent: :delete_all
  has_many :assets, through: :positions
  has_many :values, class_name: 'IndexValue', dependent: :delete_all

  validates :name, presence: true
  validate :validate_positions

  after_create :initialize!

  def initialize!
    positions.each(&:initialize!)
    #normalize_positions!
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
    self.value = calculated_last_value.value
    self.value_diff = calculated_last_value.value_diff
    self.value_diff_percent = calculated_last_value.value_diff_percent
    save!
  end

  def cleanup_cache!
    last_id = values.order(id: :desc).first.id
    return unless last_id

    values.where('id < ?', last_id).delete_all
  end

  def total_weights
    positions.sum(:weight)
  end

  def assign_codes(codes = [], parameters = {})
    codes.each do |code, weight|
      p = self.positions.new
      p.asset = Asset.find_by(code: code)
      p.weight = weight || 1
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  private

  def validate_positions
    return if positions.any?
    errors.add(:positions, 'should not be empty')
  end
end
