class VerifyController < ActionController::Base
  before_action :set, only: [:show]

  # main page for send mail
  def index
  end

  # [PUT] /verify/{id}
  def update
    if @user.status == false and params[:email].present? and params[:email].match(/@s\d{1,}\.tku\.edu\.tw\z/)
      @user.email = params[:email]
      @user.student_id = params[:email].split("@").first
      @user.save
      # send mail here
    end
  end

  # [GET] /verify/{id}?verify_code={code}
  def show
    verify_code = params[:verify_code]
    if verify_code.present? and @user.verify_code == verify_code and @user.status == false
      @user.verify_code = ''
      @user.status = true
      @user.save
      redirect_to :controller => 'login', :action => 'index'
    else
      @msg = 'verify_code is not correct.'
      render :template => 'error/index'
    end
  end

  private
    def set
      @user = User.find(params[:id])
    rescue
      @msg = 'User is not avaliable.'
      render :template => 'error/index'
    end
end
