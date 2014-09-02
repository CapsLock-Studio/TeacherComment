class Facebook::CallbackController < RegisterController

  # [GET]/facebook/callback
  def index
    if params[:code].present? and params[:state].present?
      fb_uri = "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_KEY']}&client_secret=#{ENV['FACEBOOK_SECRET']}&code=#{params[:code]}&redirect_uri=#{Rack::Utils.escape(ENV['APP_URI']+"/facebook/callback")}"
      response = request_with_ssl(fb_uri)
      response = Rack::Utils.parse_nested_query(response.body)['access_token']

      if response.present?
        require 'json'
        fb_auth_uri = "https://graph.facebook.com/me?access_token=#{response}"
        response = request_with_ssl(fb_auth_uri)
        response = JSON.parse response.body
        platform_id = response['id']
        type_id = 1
        register(platform_id, type_id)
      end
    end
  end
end
