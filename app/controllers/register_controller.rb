class RegisterController < ApplicationController
  skip_before_filter :authorize
  
  protected
    def register(platform_id, type_id)
      user = User.find_by(platform_id: platform_id, type_id: type_id)
      if user.present?
        if user.status
          enter(user)
        else
          redirect_verify(user.id)
        end
      else
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
        user = User.new
        user.verify_code = (0...10).map { o[rand(o.length)] }.join
        user.status = false
        user.platform_id = platform_id
        user.type_id = type_id
        if user.save
          redirect_verify(user.id)
        else

          raise ActionController::RoutingError.new('Not Found')
          # record not found return natural 404
          # call_image('400')
        end
      end
    end

    def request_with_ssl(uri)
      require 'net/http'
      require 'uri'
      uri = URI(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      uri = uri.request_uri
      request = Net::HTTP::Get.new(uri)
      http.request(request)
    end

  private
    def enter(user)
      user.ip = request.remote_addr || '127.0.0.1'
      user.save
      login_user(user.id)
      redirect_to teachers_path
    end

    def redirect_verify(tmp_user_id = nil)
      session[:tmp_user_id] = tmp_user_id
      redirect_to verify_index_path
    end

    def login_user(user_id)
      session[:user_id] = user_id
      session[:user] = '1'
    end
end
