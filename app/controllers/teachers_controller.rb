class TeachersController < ApplicationController
  # ensure teacher is exist
  before_action :set_teacher, only: [:show, :destroy, :edit]

  def index
    # this is main site :D
  end

  # [GET]/teachers/{teacher_id}
  def show
    respond_to do |format|
      format.json {render json: @teacher.to_a}
      format.html {}
    end
  end

  # [POST] /teachers
  def create
    if session[:user] == '2'
      @teacher = Teacher.new(teacher_params)
      respond_to do |format|
        if @teacher.save
          format.json { render json: {:teacher_id => @teacher.id} }
        else
          format.json { render json: @teacher.errors, status: :unprocessable_entity }
        end
      end
    else
      # render status: 403
    end
  end

  # [DELETE] /teachers/{teacher_id}
  def destroy
    if session[:user] == '2'
      @teacher.destroy
    end
  end
  
  private
    def set_teacher
      @teacher = Teacher.find(params[:id])
      @subject = Subject.where(:teacher_id, params[:id]).pageinator
    rescue ActiveRecord::RecordNotFound
      @msg = 'Cannot find teacher as well.'
      respond_to do |format|
        format.json {render json: {'message' => @msg}}
        format.html {render :template => 'error/index'}
      end
    end

    def teacher_params
      params.require(:teacher).permit(:name, :department)
    end
end
