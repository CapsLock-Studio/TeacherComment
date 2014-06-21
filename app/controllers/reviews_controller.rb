class ReviewsController < ApplicationController

  # [POST]/teachers/{teacher_id}/reviews
  def create
    user_id = session[:user_id]
    if params[:report].present?
      report = Report.find_by(user_id: user_id, teacher_id: params[:teacher_id])
      if report == nil
        @report = Report.new
        @report.user_id = user_id
        @report.teacher_id = params[:teacher_id]
        @report.save
      end
    end

    if params[:homework].present?
      homework = Homework.find_by(user_id: user_id, teacher_id: params[:teacher_id])
      if homework == nil
        @homework = Homework.new
        @homework.user_id = user_id
        @homework.teacher_id = params[:teacher_id]
        @homework.save
      end
    end
  end

  # [GET]/teachers/{teacher_id}/reviews
  def index
    homework = Homework.where(teacher_id: params[:teacher_id]).length
    report = Report.where(teacher_id: params[:teacher_id]).length
    if homework == 0 and report == 0
      homework = 1
      report = 1
    end
    total = homework + report
    @homework_rate = ((homework.to_f / total.to_f).to_f * 100).to_i
    @report_rate = ((report.to_f / total.to_f).to_f * 100).to_i
    respond_to do |format|
      format.html { }
      format.json { render json: {'homework_rate' => @homework_rate, 'report_rate' => @report_rate}}
    end
  end

  private
    def report_params
      params.require(:report).permit(:user_id, :teacher_id)
    end

    def homework_params
      params.require(:homework).permit(:user_id, :teacher_id)
    end
end
