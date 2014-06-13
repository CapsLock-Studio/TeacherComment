class LoginController < ApplicationController
  skip_before_filter :authorize

  def index
    if params[:code]
        # login to your facebook
        
    elsif session[:user]
        redirect_to teacher_teachers_path
    end
  end
end
