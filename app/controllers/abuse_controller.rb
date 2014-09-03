class AbuseController < ApplicationController
  before_action :set, only: [:show]
  
  # create a abuse report
  # need
  # suspector id
  # comment id
  def create
    
  end

  # /abuse/{id}?verify_code={code}
  # delete comment by verified with specified code
  def show
    verify_code = params[:verify_code]
    if verify_code == @abuse.verify_code
      c = Comment.find_by(:id => @abuse.comment_id)
      c.destroy if c.present? 
      @abuse.destroy
    end
  end

  private
    def set
      @abuse = Abuse.find(params[:id])

    # record not found return natural 404
    # rescue ActiveRecord::RecordNotFound
    #   call_image('404')
    end
end
