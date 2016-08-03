class AssetsController < ApplicationController
  def index
    @assets = Asset.page(params[:page])
  end
end
