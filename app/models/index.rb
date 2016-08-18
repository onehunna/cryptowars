class Index < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :delete_all
  has_many :assets, through: :positions
  has_many :values, class_name: 'IndexValue', dependent: :delete_all

  after_create :recalculate!

  def recalculate!
    calculated_last_value = values.create!
    self.value_diff_1h = calculated_last_value.value_diff
    save!
  end

  def last_value
    values.order(:id).last
  end

  def value
    last_value.value
  end

  def total_weights
    positions.sum(:size)
  end

  def codes=(_codes = [])
    _codes.each do |code|
      p = self.positions.new
      p.asset = Asset.find_by(code: code)
      p.size = 1
    end
  end
end
