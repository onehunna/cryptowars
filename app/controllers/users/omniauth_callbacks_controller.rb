module Users
  class OmniauthCallbacksController < ApplicationController
    include Devise::Controllers::Rememberable
    skip_before_filter :authenticate_user!

    def twitter
      @identity = UserIdentity.find_or_create_by_twitter(request.env["omniauth.auth"])
      @user = @identity.user

      remember_me @user
      sign_in @user
      redirect_to home_path
    end

    def failure

    end
  end
end
