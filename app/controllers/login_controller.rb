class LoginController < ApplicationController
  skip_before_filter :authorize
  before_action :set_fb_uri, only: [:index]
  def index
    # session[:user_id] = nil
    # session[:user] = nil
    if session[:user].present?
      redirect_to :controller => 'teachers' , :action => 'index'
    end
  end

  def create
    
  end

  private
    def set_fb_uri
      require 'digest/md5'
      @fb_login = 'http://www.facebook.com/dialog/oauth?client_id='+ENV['FACEBOOK_KEY']+'&redirect_uri='+Rack::Utils.escape(ENV['FACEBOOK_URI']+'/fblogin')+'&state='+Digest::MD5.hexdigest(SecureRandom.urlsafe_base64(nil, false))
    end
end
