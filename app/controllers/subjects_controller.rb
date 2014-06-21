class SubjectsController < ApplicationController

  # [POST]/subjects
  def create
    @name = params[:name]
    @teacher_id = params[:teacher_id]
    @subject = Subject.new(subject_params)
    respond_to do |format|
      if @subject.save
        format.html { redirect_to :controller => 'teachers', :action => 'get_comment', :teacher_id => @teacher_id, :subject_id => @subject_id}
        format.json { render json: {'created_at' => @subject.created_at}}                                 
      else
        @msg = 'Cannot add subject, the site was temporarily failed.'
        format.html { render :template => 'error/index'}
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def subject_params
      params.require(:subject).permit(:teacher_id, :name)
    end
end
