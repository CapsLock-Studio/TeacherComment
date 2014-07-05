class LogoutController < ApplicationController
  def index
    session[:user] = nil
    session[:user_id] = nil
    redirect_to login_index_path
  end
end
