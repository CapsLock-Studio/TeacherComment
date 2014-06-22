class FbloginController < RegisterController
  
  # [GET]/fblogin
  def index
    if params[:code].present? and params[:state].present?
      require 'net/http'
      require 'uri'
      fb_uri = 'https://graph.facebook.com/oauth/access_token?client_id='+ENV['FACEBOOK_KEY']+'&client_secret='+ENV['FACEBOOK_SECRET']+'&code='+params[:code]+'&redirect_uri='+Rack::Utils.escape(ENV['FACEBOOK_URI']+'/fblogin')
      response = request_with_ssl(fb_uri)
      response = Rack::Utils.parse_nested_query(response.body)['access_token']
      if response.present?
        require 'json'
        fb_auth_uri = 'https://graph.facebook.com/me?access_token='+response
        response = request_with_ssl(fb_auth_uri)
        response = JSON.parse response.body
        user_id = response['id']
        platform_id = 1
        register(user_id, platform_id)
      end
    end
  end
end
