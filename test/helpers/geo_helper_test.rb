require './lib/helpers/geo_helper'
require 'test/unit'

class GeoHelperTest < Test::Unit::TestCase
  include Sinatra::GeoHelper
  
  def test_get_atitude_longitude_via_ip
    geo = get_geo("99.237.137.13")
    assert_equal "43.86669921875", geo[0]
    assert_equal "-79.433296203613", geo[1]
  end
end
