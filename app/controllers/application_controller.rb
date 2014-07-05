class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize

  protected
    def call_image(code = '403')
      @msg = code
      respond_to do |format|
        format.json {render json: {'msg' => @msg}}
        format.html {render :template => 'view/index'}
      end
    end

  private
    def authorize
      if session[:tmp_user_id].present?
      #   redirect_to verify_index_path
      # else 
      #   redirect_to login_index_path unless session[:user]
      #   user = User.find_by(session[:user_id])
      #   user.ip = request.remote_addr || '127.0.0.1'
      #   user.save
      end
    end
end
