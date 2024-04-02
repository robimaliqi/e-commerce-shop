module Users 
  class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
      else
        flash.now[:alert] = "Invalid Email or password"
        render :new
      end
    end
  end
end