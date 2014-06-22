class CommentsController < ApplicationController
  before_action :set_subject, only: [:create]
  before_action :set_comment, only: [:index]

  # [POST]/subjects/{subject_id}/comments
  def create
    if @comment.present?
      @comment = Comment.new(comment_params)
      @comment.user_id = session[:user_id]
      respond_to do |format|
        if @comment.save
          format.html { redirect_to :controller => 'comments', :action => 'index', :subject_id => @subject_id}
          format.json { render json: {'created_at' => @comment.created_at}}                                 
        else
          @msg = 'Cannot add comment, the site was temporarily down.'
          format.html { render :template => 'error/index' }
          format.json { render json: @msg, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        @msg = 'comment cannot be empty!'
        format.html { render :template => 'error/index' }
        format.json { render json: {'message' => @msg}}
      end
    end

  # [GET] /comment/1
  # [GET] /comment/1.json
  def show
    # show render
    @animals = [
        {
          name: '大象',
          icon: 'elephant'
        },
        {
          name: '食蟻獸',
          icon: 'anteater'
        },
        {
          name: '恐龍',
          icon: 'dinosaur'
        },
        {
          name: '澳洲土狗',
          icon: 'dingo'
        },
        {
          name: '蟒蛇',
          icon: 'python'
        },
        {
          name: '狐狸',
          icon: 'fox'
        }
    ]
  end

  # [GET]/subjects/{subject_id}/comments
  def index
    @page = params[:page] || 0
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
      @comment = Comment.where!(:subject_id, params[:subject_id]).pageinator
    rescue ActiveRecord::RecordNotFound
      @comment = {}
    end

    def set
      # @comment = Comment.find(params[:id])
    end
end
