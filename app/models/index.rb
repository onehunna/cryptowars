class Index < ApplicationRecord
  belongs_to :user
  has_many :positions
  has_many :assets, through: :positions

  def recalculate
    # assets.each do |asset|
    #   asset.values.last
    # end
  end
end
