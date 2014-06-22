class ReviewsController < ApplicationController

  # [POST]/subjects/{subject_id}/reviews
  def create
    user_id = session[:user_id]
    subject_id = params[:subject_id]

    # for report ratio
    if params[:report].present?
      report = Report.find_by(user_id: user_id, subject_id: params[:subject_id])
      if report.present?
        @report = Report.new(report_params)
        @report.user_id = user_id
        @report.subject_id = subject_id
        @report.save
      end
    end

    # for homework ratio
    if params[:homework].present?
      homework = Homework.find_by(user_id: user_id, subject_id: params[:subject_id])
      if homework.present?
        @homework = Homework.new
        @homework.user_id = user_id
        @homework.subject_id = subject_id
        @homework.save
      end
    end

    respond_to do |format|
      format.html { redirect_to :controller => 'subjects', :action => 'show', :subject_id => subject_id}
      format.json { render json: { 'timestamp' => Time.now.strftime('%I:%M:%S') }}
    end
  end

  # [GET]/subjects/{subject_id}/reviews
  def index
    homework = Homework.count(:id, condition: { subject_id: params[:subject_id] })
    report = Report.count(:id, condition: { subject_id: params[:subject_id] })

    if homework == 0 and report == 0
      homework = 1
      report = 1
    end

    total = homework + report
    @homework_rate = '%.2f' % ((homework.to_f / total.to_f).to_f * 100)
    @report_rate = '%.2f' % ((report.to_f / total.to_f).to_f * 100)
    respond_to do |format|
      format.html { redirect_to :controller => 'subjects', :action => 'show', :subject_id => params[:subject_id]}
      format.json { render json: {'homework_rate' => @homework_rate, 'report_rate' => @report_rate}}
    end
  end

  private
    def report_params
      params.require(:report).permit(:subject_id)
    end

    def homework_params
      params.require(:homework).permit(:subject_id)
    end
end
