class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def index
    @indices = Index.all.order(value_cents: :desc)
  end
end
