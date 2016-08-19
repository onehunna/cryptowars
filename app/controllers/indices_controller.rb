class IndicesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index]
  def new
    @assets = Asset.by_importance
    @index = Index.new
  end

  def create
    @index = current_user.indices.new
    @index.name = params[:index][:name]
    @index.codes = params[:index][:codes]
    @index.save!

    redirect_to index_path(@index)
  end

  def show
    @index = Index.find(params[:id])
  end
end
