class IndicesController < ApplicationController
  def new
    @assets = Asset.all
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
