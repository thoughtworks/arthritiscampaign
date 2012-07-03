# coding: utf-8
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
        "&caption=#{CGI.escape(tumblr_message)}" +
        "&click_thru=#{CGI.escape(request.url)}"
    end
    
    def share_to_twitter_url(photo_url)
      "https://twitter.com/intent/tweet?source=webclient&text=#{CGI.escape(twitter_message(photo_url))}&via=ArthritisSoc"
    end


    def facebook
      @facebook_sharing ||= Sharing::Facebook.new(settings.fb_app_id, settings.fb_app_secret)
    end

    def flickr
      @flickr_sharing ||= Sharing::Flickr.new(settings.flickr_api_key, settings.flickr_secret, settings.flickr_access_token, settings.flickr_access_secret)
    end
    
    def facebook_message
       settings.language == 'en' ?
         "Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://Campaign.arthrite.ca/"
         : "Apportez votre soutien aux 4,6 millions de Canadiens souffrant d’arthrite! Regardez la vidéo et partagez-la! http://Campagne.arthrite.ca/"
    end

    def tumblr_message
      settings.language == 'en' ?
        "I support 4.6 million Canadians living with arthritis! Do you?"
        : "J’apporte mon soutien aux 4,6 millions de Canadiens souffrant d’arthrite! Et vous?"
    end
     
    def twitter_message(photo_url)
      settings.language == 'en' ?
        "Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://Campaign.arthrite.ca/"
        : "Apportez votre soutien aux 4,6 millions de Canadiens souffrant d’arthrite! Regardez la vidéo et partagez-la! http://Campagne.arthrite.ca/"
    end

  end
  helpers ApplicationHelper
end
