class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  private
  	def authorize
        # redirect_to :controller => 'login' , :action => 'index' unless session[:user]
    end
end
