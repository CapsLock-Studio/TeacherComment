class VerifyController < ApplicationController
  before_action :set, only: [:show, :create]
  skip_before_filter :authorize
  protect_from_forgery

  # main page for send mail
  # [GET] /verify
  # need redirect from any register page
  def index
    if not session[:tmp_user_id].present?
      redirect_to login_index_path
    end
  end

  # [POST] /verify
  def create
    regex = Regexp.new ENV['MAIL_REGEX']
    email = params[:email]
    if @user.status == false and email.present? and regex.match(params[:email])
      @user.email = email
      @user.student_id = email.split("@").first
      @user.save
      reset_session
      RegistrationMail.reciever(@user.email, @user.id, @user.verify_code).deliver
      @state = true
    else
      @state = false
    end
  end

  # [GET] /verify/{id}?verify_code={code}
  def show
    verify_code = params[:verify_code]
    if verify_code.present? and @user.verify_code == verify_code and @user.status == false
      @user.verify_code = nil
      @user.status = true
      @user.save
      session[:user] = '1'
      session[:user_id] = @user.id
      redirect_to login_index_path
    else
      call_image('404')
    end
  end

  private
    def set
      @user = User.find(params[:id])
    rescue
      call_image('404')
    end
end
