class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  protected
    def register
      user = User.find_by(platform_id: @platform_id, type_id: @type_id)
      if user.present?
        if user.status == true
          @user_id = user.id
          user.ip = request.remote_ip;
          user.save
          login_user
          redirect_to :controller => 'teachers', :action => 'index'
        end
      else
        redirect_to :controller => 'verify', :action => 'index'
      end
    end

  private
    def authorize
      # redirect_to :controller => 'login' , :action => 'index' unless session[:user]
    end

    def login_user
      session[:user_id] = @user_id
      session[:user] = '1'
    end
end
