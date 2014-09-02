class LoginController < ApplicationController
  skip_before_filter :authorize
  before_action :set_fb_uri, only: [:index]

  def index
    session[:tmp_user_id] = nil
    if session[:user].present?
      redirect_to teachers_path
    end
  end

  private
    def set_fb_uri
      require 'digest/md5'
      @fb_uri = "http://www.facebook.com/dialog/oauth?client_id=#{ENV['FACEBOOK_KEY']}&redirect_uri=#{Rack::Utils.escape(ENV['APP_URI']+"/facebook/callback")}&state=#{Digest::MD5.hexdigest(SecureRandom.urlsafe_base64(nil, false))}"
    end
end
