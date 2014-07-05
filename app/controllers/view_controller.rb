class ViewController < ActionController::Base
  def index
    @msg = params[:msg]
  end
end
