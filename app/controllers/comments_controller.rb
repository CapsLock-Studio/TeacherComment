# encoding: utf-8
class CommentsController < ApplicationController
  before_action :set_subject
  before_action :set_comment, only: [:index]

  # [POST]/subjects/{subject_id}/comments
  def create
    if params[:comment].present? and !params[:comment].blank?
      comment = Comment.new(comment_params)
      comment.user_id = session[:user_id]
      comment.teacher_id = @subject.teacher_id
      respond_to do |format|
        if comment.save
          format.html { redirect_to subject_comments_path(params[:subject_id])}
          format.json { render json: {'created_at' => comment.created_at}}                                 
        else
          redirect_to subject_comments_path(params[:subject_id])
        end
      end
    else
      redirect_to subject_comments_path(params[:subject_id])
    end
  end

  # [GET]/subjects/{subject_id}/comments
  def index
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
          name: '澳洲野犬',
          icon: 'dingo'
        },
        {
          name: '蟒蛇',
          icon: 'python'
        },
        {
          name: '狐狸',
          icon: 'fox'
        },
        {
          name: '駱駝',
          icon: 'camel'
        },
        {
          name: '袋鼠',
          icon: 'kangaroo'
        },
        {
          name: '老虎',
          icon: 'tiger'
        },
        {
          name: '變色龍',
          icon: 'chamleon'
        },
        {
          name: '袋熊',
          icon: 'wombat'
        },
        {
          name: '野鶴',
          icon: 'magpie'
        },
        {
          name: '熊貓',
          icon: 'panda'
        },
        {
          name: '角鯨',
          icon: 'narwhal'
        },
        {
          name: '原牛',
          icon: 'auroch'
        },
        {
          name: '獅虎',
          icon: 'liger'
        },
        {
          name: '猴子',
          icon: 'monkey'
        },
        {
          name: '鯤',
          icon: 'kraken'
        },
        {
          name: '斑馬',
          icon: 'zebra'
        },
        {
          name: '烏鴉',
          icon: 'crow'
        },
        {
          name: '浣熊',
          icon: 'raccoon'
        },
        {
          name: '海牛',
          icon: 'manatee'
        },
        {
          name: '短吻鱷',
          icon: 'alligator'
        },
        {
          name: '海豚',
          icon: 'dolphin'
        },
        {
          name: '無尾熊',
          icon: 'koala'
        }
    ]

    @report = Report.positive(params[:subject_id]) - Report.negative(params[:subject_id])
    @test = Test.positive(params[:subject_id]) - Test.negative(params[:subject_id])

    if @report == 0 and @test == 0
      report = 1
      test = 1
    else
      report = @report
      test = @test
    end

    total = test.to_i + report.to_i
    @report_rate = '%.2f' % ((report.to_f / total.to_f).to_f * 100)
    @test_rate = '%.2f' % ((test.to_f / total.to_f).to_f * 100)
    @report_clicked = Report.find_by(:subject_id => params[:subject_id], :user_id => session[:user_id]).present?
    @test_clicked = Test.find_by(:subject_id => params[:subject_id], :user_id => session[:user_id]).present?

    respond_to do |format|
      format.html {}
      format.json {render json: {
        'current' => @page,
        'total' => @total_page,
        'comment' => @comment.to_a,
        'test_rate' => @test_rate,
        'report_rate' => @report_rate,
        'test' => @test,
        'report' => @report,
        'test_clicked' => @test_clicked,
        'report_clicked' => @report_clicked
        }
      }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:subject_id, :comment)
    end

    def set_subject
      @subject = Subject.find(params[:subject_id])
    rescue
      call_image('404')
    end

    def set_comment
      @total_page = (Comment.with_condition(params[:subject_id]).count(:id) / 20 ).to_i + 1
      @page = params[:page].present? && params[:page].to_i > 0 ? (params[:page].to_i > @total_page ? @total_page : params[:page] ) : 1
      @comment = Comment.get(params[:subject_id], @page)
    rescue ActiveRecord::RecordNotFound
      call_image('404')
    end
end
