class VerifyController < ActionController::Base
  before_action :set, only: [:show]

  # main page for send mail
  def index
    
  end

  # [GET] /verify/{id}?verify_code={code}
  def show
    verify_code = params[:verify_code]
    if params[:verifyCode].present? and @user.verify_code == verify_code and @user.status == false
      @user.verify_code = ''
      @user.status = true
      @user.save
      redirect_to :controller => 'login', :action => 'index'
    else
      @msg = 'Verify_code is not same.'
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
