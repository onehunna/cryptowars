class AssetsController < ApplicationController
  def index
    @assets = Asset.page(params[:page])
  end

  def roll_dice
    @assets = Asset.all.select(:id, :name, :code)
    render json: @assets.sample(6).to_json
  end
end
