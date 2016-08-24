class IndicesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index]

  def new
    if current_user.indices.count >= Index::MAX_INDICES_PER_USER
      redirect_to root_path, notice: "You've reached the max amount of #{Index::MAX_INDICES_PER_USER} indices per user"
    end

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

  def destroy
    index = current_user.indices.find(params[:id]).destroy
    notice = index ? "Index #{index.name} deleted" : ""
    redirect_to root_path, notice: notice
  end

  def show
    @index = Index.find(params[:id])
  end
end
