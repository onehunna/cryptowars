class IndicesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index]
  def new
    @assets = Asset.by_importance
    @index = Index.new
  end

  def create
    unless params[:index][:codes]
      flash[:error] = 'You have to chose at least one asset'
      return redirect_to new_index_path
    end

    @index = current_user.indices.new
    @index.name = params[:index][:name]
    @index.assign_codes(params[:index][:codes])

    unless @index.save
      render :new
    end

    redirect_to index_path(@index)
  end

  def show
    @index = Index.find(params[:id])
  end
end
