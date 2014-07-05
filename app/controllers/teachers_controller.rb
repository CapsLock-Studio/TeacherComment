class TeachersController < ApplicationController
  before_action :initialize_teacher, only: [:index]
  before_action :set_teacher, only: [:show]

  # this is subject for specified teacher(ajax)
  # [GET]/teachers/{id}
  def show
    @total_page = (@teacher.subject.count(:id) / 4).to_i + 1;
    @page = params[:page].present? ? (params[:page].to_i > @total_page ? @total_page : params[:page] ) : 1
    @subject = @teacher.subject.pageinator(@page)
    @comment = {}
    @subject.each do |s|
      @comment[s.id] = s.comment.count(:id)
    end
    respond_to do |format|
      format.html {}
      format.json {render json: {'current' => @page, 'total' => @total_page, 'subject' => @subject, 'subject_comment_total' => @comment}}
    end
  end

  # [GET]/teachers
  def index
    @subject = {}
    @comment = {}
    @teacher.each do |t|
      @subject[t.id] = t.subject.pageinator(1)
      @subject[t.id].each do |s|
        @comment[s.id] = s.comment.count(:id)
      end
    end

    @min = @page.to_i > 5 ? (@page.to_i - 4) : 1
    @max = @min.to_i + 9 > @total_page.to_i ? @total_page.to_i - @min.to_i + 1 : 9

    respond_to do |format|
      format.html {}
      format.json {render json:{'current' => @page, 'total' => @total_page,'teacher' => @teacher, 'subject' => @subject, 'subject_comment_total' => @comment}}
    end
  end

  private
    def initialize_teacher
      if params[:search].present?
        search_string = 'name like :name'
        condition = "%#{params[:search]}%"
        @total_page = (Teacher.where(search_string, {:name => condition}).count(:id) / 10).to_i + 1;
        @page = params[:page].present? && params[:page].to_i > 0 ? (params[:page].to_i > @total_page ? @total_page : params[:page] ) : 1
        @teacher = Teacher.select(:id, :name, :department, :avatar).where(search_string, {:name => condition}).pageinator(@page)
      elsif params[:department].present?
        search_string = 'department = :department'
        @total_page = (Teacher.where(:department => params[:department] || 1).count(:id) / 10).to_i + 1;
        @page = params[:page].present?  && params[:page].to_i > 0 ? (params[:page].to_i > @total_page ? @total_page : params[:page] ) : 1
        @teacher = Teacher.select(:id, :name, :department, :avatar).where(search_string, {:department => params[:department] || 1}).pageinator(@page)
      else
        @total_page = (Teacher.count(:id) / 10).to_i + 1;
        @page = params[:page].present?  && params[:page].to_i > 0 ? (params[:page].to_i > @total_page ? @total_page : params[:page] ) : 1
        @teacher = Teacher.select(:id, :name, :department, :avatar).pageinator(@page)
      end 
    rescue ActiveRecord::RecordNotFound
      call_image('404')
    end

    def set_teacher
      @teacher = Teacher.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      call_image('404')
    end

    def teacher_params
      params.require(:teacher).permit(:name, :department)
    end
end
