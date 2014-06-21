class CommentsController < ApplicationController
  before_action :set_subject, only: [:create]
  before_action :set_comment, only: [:index]

  # [POST]/subjects/{subject_id}/comments
  def create
    @comment = params[:comment]
    @user_id = session[:user_id]
    @subject_id = params[:subject_id]
    if @comment.present?
      @comment = Comment.new(comment_params)
      respond_to do |format|
        if @comment.save
          format.html { redirect_to :controller => 'comments', :action => 'index', :subject_id => @subject_id}
          format.json { render json: {'created_at' => @comment.created_at}}                                 
        else
          @msg = 'Cannot add comment, the site was temporarily down.'
          format.html { render :template => 'error/index' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        # format.json { render json: {'message' =>''}}
      end
    end
  end

  # [GET]/subjects/{subject_id}/comments
  def index
    respond_to do |format|
      format.html {}
      format.json {render json: @comment.to_a}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:subject_id, :user_id, :comment)
    end

    def set_subject
      @subject = Subject.find_by!(id: params[:subject_id])
    rescue
      @msg = 'Cannot find subject as well'
      render :template => 'error/index'
    end

    def set_comment
      @comment = Comment.where!('subject_id = :subject_id', {subject_id: params[:subject_id]})
    rescue
      @comment = {}
    end
end
