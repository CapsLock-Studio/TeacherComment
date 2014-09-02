class ReviewsController < ApplicationController
  before_action :filter_param, only: [:create]
  protect_from_forgery

  # using ajax for post
  # [POST]/subjects/{subject_id}/reviews
  def create
    report = Report.find_by(user_id: session[:user_id], subject_id: params[:subject_id])
    report_total = Report.positive(params[:subject_id]) - Report.negative(params[:subject_id])
    # for report ratio
    if params[:report].present? and (params[:report] == 1 or params[:report] == -1)
      if not report.present? and !(params[:report].to_i < 0 and report_total < 0)
        report = Report.new
        report.user_id = session[:user_id]
        report.subject_id = params[:subject_id]
        report.review = params[:report].to_i
        report.save
      end
    end

    test = Test.find_by(user_id: session[:user_id], subject_id: params[:subject_id])
    test_total = Test.positive(params[:subject_id]) - Test.negative(params[:subject_id])
    # for test ratio
    if params[:test].present? and (params[:test] == 1 or params[:test] == -1)
      if not test.present? and !(params[:test].to_i < 0 and test_total < 0)
        test = Test.new
        test.user_id = session[:user_id]
        test.subject_id = params[:subject_id]
        test.review = params[:test].to_i
        test.save
      end
    end

    respond_to do |format|
      format.html { redirect_to subject_comments_path(params[:subject_id])}
      format.json { render json: { 'timestamp' => Time.now.strftime('%I:%M:%S') }}
    end
  end

  private
    def filter_param
      params[:report] = nil unless (params[:report] != 1 || params[:report] != -1)
      params[:test] = nil unless (params[:test] != 1 || params[:test] != -1)
    end
end
