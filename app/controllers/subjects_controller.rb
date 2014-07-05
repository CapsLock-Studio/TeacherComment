class SubjectsController < ApplicationController

  # [POST]/subjects
  def create
    if params[:teacher_id].present? and Subject.find_by(:teacher_id => params[:teacher_id], :name => params[:name]).present?
      @subject = Subject.new(subject_params)
      respond_to do |format|
        if @subject.save
          format.html { redirect_to subject_comments_path(@subject.id)}
          format.json { render json: {'created_at' => @subject.created_at}}                                 
        else
          call_image('400')
        end
      end
    else
      # error
    end
  end

  private
    def subject_params
      params.require(:subject).permit(:teacher_id, :name)
    end
end
