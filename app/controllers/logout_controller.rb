class LogoutController < ApplicationController
  def index
    reset_session
    redirect_to login_index_path
  end
end
