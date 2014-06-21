class ErrorController < ActionController::Base
  def index
  	@msg = params[:msg]
  end
end
