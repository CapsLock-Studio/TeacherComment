class CommentsController < ApplicationController
  before_action :set, only: [:show]

  # [GET] /comment/1
  # [GET] /comment/1.json
  def show
    # show render
  end

  def create
    @comment = Comment.new
  end

  private
    def set
      @comment = Comment.find(params[:id])
    end
end
