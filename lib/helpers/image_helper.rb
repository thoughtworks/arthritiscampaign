require 'sinatra/base'
require 'mini_magick'

module Sinatra
  module ImageHelper
    MAXIMUM_SIZE = 500

    def add_logo(image_path, color_scheme)
      user_img = MiniMagick::Image.open(image_path)
      user_img.resize "#{MAXIMUM_SIZE}x#{MAXIMUM_SIZE}"
      user_img.auto_orient

      logo_path = logo_in(color_scheme)
      weloveiran_img = MiniMagick::Image.open(logo_path)
      resize(user_img, weloveiran_img, logo_path)

      result = user_img.composite(weloveiran_img) do |c|
        c.gravity "Southeast"
      end

      result
    end

    def is_an_image?(photo)
      photo && (photo[:type] =~ /image\/.+/)
    end

    private
    def resize(image, banner, banner_path)
      max_size = image[:width]
      max_size *= 0.3 if round?(banner_path) || landscape?(image)

      banner.resize "#{max_size}x#{max_size}"
    end

    def logo_in(color_scheme)
      "static/images/banners/#{color_scheme}.png"
    end

    def round?(banner_path)
      banner_path =~ /round\.png/
    end

    def landscape?(image)
      image[:width] > image[:height]
    end
  end

  helpers ImageHelper
end
