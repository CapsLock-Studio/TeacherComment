class RegisterController < ActionController::Base

  protected
    def register(platform_id, type_id)
      user = User.find_by(platform_id: platform_id, type_id: type_id)
      if user.present?
        if user.status == true
          enter(user.id)
        else
          redirect_verify
        end
      else
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
        user = User.new
        user.verify_code = (0...10).map { o[rand(o.length)] }.join
        user.status = false
        user.platform_id = platform_id
        user.type_id = type_id
        if user.save
          redirect_verify
        else
          @msg = 'save user error'
          respond_to do |format|
            format.json {render json: {'message' => @msg}}
            format.html {redirect_to :controller => 'error', :action => 'index'}
          end
        end
      end
    end

    def request_with_ssl(uri)
      uri = URI(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      uri = uri.request_uri
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      response
    end

  private
    def enter(user)
      user.ip = request.remote_ip;
      user.save
      login_user(user.id)
      redirect_to :controller => 'teachers', :action => 'index'
    end

    def redirect_verify
      redirect_to :controller => 'verify', :action => 'index'
    end

    def login_user(user_id)
      session[:user_id] = user_id
      session[:user] = '1'
    end
end
