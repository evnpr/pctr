class SessionsController < ApplicationController
    def create
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      cookies[:user_id] = user.id
      redirect_to "/site/home", :notice => "Signed in!"
    end

    def destroy
      cookies.delete(:user_id)
      redirect_to root_url, :notice => "Signed out!"
    end
end
