require './lib/helpers/image_helper'
require 'test/unit'
require 'rack/test'
require 'mocha'

class ImageHelperTest < Test::Unit::TestCase
  include Sinatra::ImageHelper

  def test_use_small_logo_if_photo_is_a_square
    photo = { :width => 500, :height => 500 }

    assert use_small_logo?(photo, 'banner_path')
  end

  def test_use_small_logo_if_photo_is_landscape
    photo = { :width => 200, :height => 100 }

    assert use_small_logo?(photo, 'banner_path')
  end

  def test_use_small_logo_if_photo_is_close_to_a_square
    photo = { :width => 86, :height => 100 }

    assert use_small_logo?(photo, 'banner_path')
  end

  def test_use_big_logo_if_photo_is_portrait
    photo = { :width => 100, :height => 200 }

    assert_equal false, !!use_small_logo?(photo, 'banner_path')
  end

  def test_use_big_logo_if_photo_is_close_to_a_portrait
    photo = { :width => 85, :height => 100 }

    assert_equal false, !!use_small_logo?(photo, 'banner_path')
  end

  def test_use_small_logo_if_photo_is_round
    any_photo = { :width => 100, :height => 200 }

    assert use_small_logo?(any_photo, 'banner_path_round.png')
  end

  def test_gravity_to_southeast_if_we_should_use_small_logo
    stubs(:use_small_logo?).returns(true)

    assert_equal "Southeast", gravity(:image, :banner_path)
  end

  def test_gravity_to_south_if_we_should_use_big_logo
    stubs(:use_small_logo?).returns(false)

    assert_equal "South", gravity(:image, :banner_path)
  end
end
