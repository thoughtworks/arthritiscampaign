require 'uri'
require 'cgi'
require 'sharing/facebook'
require 'sharing/flickr'

module Sinatra
  module ApplicationHelper

    def facebook_callback_url(photo_id)
      'http://' + request.host_with_port + '/callback/facebook/' + photo_id
    end

    def share_to_tumblr_url(photo_url)
      "http://www.tumblr.com/share/photo?source=#{CGI.escape(photo_url)}" +
        "&caption=#{URI.escape('I support 4.6 million Canadians living with arthritis! Do you?')}" +
        "&click_thru=#{CGI.escape(request.url)}"
    end

    def facebook
      @facebook_sharing ||= Sharing::Facebook.new(settings.fb_app_id, settings.fb_app_secret)
    end

    def flickr
      @flickr_sharing ||= Sharing::Flickr.new(settings.flickr_api_key, settings.flickr_secret, settings.flickr_access_token, settings.flickr_access_secret)
    end
    
    def facebook_message
      "Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://www.goriete.com/page.aspx?pid=6324"
    end

    def share_to_twitter_url(photo_url)
      "https://twitter.com/intent/tweet?source=webclient&text=#{twitter_message(photo_url)}&via=ArthritisSoc"
    end
  
    def twitter_message(photo_url)
      URI.escape("Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://www.goriete.com/page.aspx?pid=6324")
    end

  end
  helpers ApplicationHelper
end
