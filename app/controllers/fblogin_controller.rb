class FbloginController < ActionController::Base
  
  def index
    if params[:code].present? and params[:state].present?
      require 'net/http'
      require 'uri'
      fb_uri = 'https://graph.facebook.com/oauth/access_token?client_id='+ENV['FACEBOOK_KEY']+'&client_secret='+ENV['FACEBOOK_SECRET']+'&code='+params[:code]+'&redirect_uri='+Rack::Utils.escape(ENV['FACEBOOK_URI']+'/fblogin')
      uri = URI(fb_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      uri = uri.request_uri
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      response = Rack::Utils.parse_nested_query(@response.body)['access_token']
      if response.present?
        
      end
    end
  end
end
