class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  helper_method :home_path,
                :body_attrs, :body_id, :body_class, :page_title

  # Devise overrides

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || dashboard_path
  end

  # Global home path helper

  def home_path(*args)
    # if current_user
    #   dashboard_path(*args)
    # else
      root_path(*args)
    # end
  end

  # CSS hooks

  def body_id
    "#{controller_name}-#{action_name}"
  end

  def body_class
    controller_name
  end

  def body_attrs
    { :class => body_class, :id => body_id }
  end

  private

  def page_title
    return @full_page_title if @full_page_title

    if @page_title
      "#{@page_title} (Cryptowars)"
    else
      "Cryptowars"
    end
  end
end
