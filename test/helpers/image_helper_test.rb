require './lib/helpers/image_helper'
require 'test/unit'
require 'rack/test'
require 'mocha'

class ImageHelperTest < Test::Unit::TestCase
  include Sinatra::ImageHelper

  def test_use_middle_log_if_photo_is_a_square
    photo = { :width => 500, :height => 500 }

    assert_equal define_max_size(photo, 'banner_path'), 315
  end

  def test_use_middle_logr_if_photo_i_landscape
    photo = { :width => 200, :height => 100 }

    assert_equal define_max_size(photo, 'banner_path').to_i, 125
  end

 
  def test_use_big_logo_if_photo_is_portrait
    photo = { :width => 100, :height => 200 }

    assert_equal define_max_size(photo, 'banner_path'), 90
  end

  
  def test_use_small_logo_if_photo_is_small
    photo = { :width => 100, :height => 100 }

    assert_equal define_max_size(photo, 'banner_small_path').to_i, 44
  end

  def test_gravity_to_southeast_if_banner_is_small
    photo = { :width => 200, :height => 100 }

    assert_equal "Southeast", gravity(photo, 'banner_small_path')
  end

  def test_gravity_to_southeast_if_image_is_lanscape
    photo = { :width => 200, :height => 100 }

    assert_equal "Southeast", gravity(photo, 'banner_small_path')
  end


  def test_gravity_to_south_if_image_is_portait
    photo = { :width => 200, :height => 400 }

    assert_equal "South", gravity(photo, 'banner_path')

  end

 
end
