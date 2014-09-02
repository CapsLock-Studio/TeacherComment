class TeachersController < ApplicationController
  before_action :initialize_teacher, only: [:index]
  before_action :set_teacher, only: [:show]

  # this is subject for specified teacher(ajax)
  # [GET]/teachers/{id}
  def show
    @total_page = (@teacher.subject.count(:id) / 4).to_i + 1
    @page = get_current_page
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
    @comment_count = {}
    @teacher.each do |t|
      @comment_count[t.id] = Teacher.find_by(:id => t.id).comment.count(:id)
      @subject[t.id] = t.subject.pageinator(1)
      @subject[t.id].each do |s|
        @comment[s.id] = s.comment.count(:id)
      end
    end

    @min = @page.to_i > 5 ? (@page.to_i - 4) : 1
    @max = @min.to_i + 9 > @total_page.to_i ? @total_page.to_i - @min.to_i + 1 : 9

    respond_to do |format|
      format.html {}
      format.json {render json:{'current' => @page, 'total' => @total_page,'teacher' => @teacher, 'subject' => @subject, 'subject_comment_total' => @comment, 'teacher_comment_total' => @comment_count}}
    end
  end

  private
    def initialize_teacher
      if params[:search].present?
        search_string = 'name like :name'
        condition = "%#{params[:search]}%"
        @total_page = (Teacher.with_condition(search_string, {:name => condition}).count(:id) / 10).to_i + 1
        @page = get_current_page
        @teacher = Teacher.find_with_condition(search_string, {:name => condition}, @page)
      elsif params[:department_id].present?
        search_string = 'department_id = :department_id'
        @total_page = (Teacher.with_condition(search_string, {:department_id => params[:department_id]}).count(:id) / 10).to_i + 1
        @page = get_current_page
        @teacher = Teacher.find_with_condition(search_string, {:department_id => params[:department_id]}, @page)
      else
        @total_page = (Teacher.count(:id) / 10).to_i + 1
        @page = get_current_page
        @teacher = Teacher.with_select.pageinator(@page)
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
      params.require(:teacher).permit(:name, :department_id)
    end

    def get_current_page
      params[:page].present? && params[:page].to_i > 0 ? (params[:page].to_i > @total_page ? @total_page : params[:page] ) : 1
    end
end
