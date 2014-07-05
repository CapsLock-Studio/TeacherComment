class ReviewsController < ApplicationController
  protect_from_forgery

  # using ajax for post
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
        @report.review = params[:report].to_i
        @report.save
      end
    end

    # for test ratio
    if params[:test].present?
      test = Test.find_by(user_id: user_id, subject_id: params[:subject_id])
      if test.present?
        @test = Test.new
        @test.user_id = user_id
        @test.subject_id = subject_id
        @test.review = params[:test].to_i
        @test.save
      end
    end

    respond_to do |format|
      format.html { redirect_to subject_comments_path(subject_id)}
      format.json { render json: { 'timestamp' => Time.now.strftime('%I:%M:%S') }}
    end
  end
end
