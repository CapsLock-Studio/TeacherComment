class CommentsController < ApplicationController
  before_action :set, only: [:show]

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

  def create
    @comment = Comment.new
  end

  private
    def set
      # @comment = Comment.find(params[:id])
    end
end
