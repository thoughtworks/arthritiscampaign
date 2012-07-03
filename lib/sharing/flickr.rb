require 'flickraw'

module Sharing
  class Flickr
    def initialize(api_key, secret, access_token, access_secret)
      FlickRaw.api_key = api_key
      FlickRaw.shared_secret = secret
      @access_token = access_token
      @access_secret = access_secret
    end

    def upload(file_name)
      photo_id = client.upload_photo file_name, :is_public => true, :title => 'We Have Arthritis!', :tags => settings.campaign
      puts "#{file_name} uploaded to flickr." 
      photo_id
    end
    
    def set_location(photo_id, latitude, longitude)
        return if latitude == nil  or latitude.length == 0
    	client.photos.geo.setLocation :photo_id => photo_id, :lat => latitude.to_f, :lon => longitude.to_f, :accuracy => 16
        puts "location #{latitude}, #{longitude} to photo #{photo_id} is set."
    end

    def add_to_set(photo_id)
      client.photosets.addPhoto :photo_id => photo_id, :photoset_id => settings.flickr_photoset_id if settings.flickr_photoset_id
    end 

    def photo_url(photo_id)
      info = client.photos.getInfo(:photo_id => photo_id)
      FlickRaw.url_b(info)
    end

    private

    def client
      unless @client
        @client ||= FlickRaw::Flickr.new
        @client.access_token = @access_token
        @client.access_secret = @access_secret
      end
      @client
    end
  end
end
