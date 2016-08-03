class Index < ApplicationRecord
  belongs_to :user
  has_many :positions
  has_many :assets, through: :positions

  def recalculate
    # assets.each do |asset|
    #   asset.values.last
    # end
  end

  def codes=(codes=[])
    codes.each do |code|
      p = self.positions.new
      p.asset = Asset.find_by(code: code)
      p.size = 1
    end
  end
end
