# coding: utf-8
require 'uri'
require 'cgi'
require 'sharing/facebook'
require 'sharing/flickr'

module Sinatra
  module ApplicationHelper

    def facebook_callback_url(photo_id)
      'http://' + request.host_with_port + '/callback/facebook/' + photo_id + "&language=#{settings.language}"
    end

    def share_to_tumblr_url(photo_url)
      "http://www.tumblr.com/share/photo?source=#{CGI.escape(photo_url)}" +
        "&caption=#{CGI.escape(t.tumblr_message)}" +
        "&click_thru=#{CGI.escape(request.url)}"
    end
    
    def share_to_twitter_url(photo_url)
      account = settings.language == 'fr' ? 'SOCIETEARTHRITE' : 'ArthritisSoc'
      "https://twitter.com/intent/tweet?source=webclient&text=#{CGI.escape(t.twitter_message(tiny_url(photo_url)))}&via=#{account}"
    end


    def facebook
      @facebook_sharing ||= Sharing::Facebook.new(settings.fb_app_id, settings.fb_app_secret)
    end

    def flickr
      @flickr_sharing ||= Sharing::Flickr.new(settings.flickr_api_key, settings.flickr_secret, settings.flickr_access_token, settings.flickr_access_secret)
    end
    
  end
  helpers ApplicationHelper
end
