class VerifyController < ApplicationController
  def show
    
  end

  private
    def set
      @user = User.find(params[:id])
    end
end
