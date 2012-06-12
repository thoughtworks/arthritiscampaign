require 'sinatra/base'
require "net/http"
require "xmlsimple"
require "uri"

module Sinatra
  module GeoHelper
    def get_geo(ip)
      uri = URI.parse("http://www.geoplugin.net/xml.gp?ip=#{ip}")
      response = Net::HTTP.get_response(uri)
      result = XmlSimple.xml_in(response.body)
      [result["geoplugin_latitude"][0], result["geoplugin_longitude"][0]]
    end
  end
  helpers GeoHelper
end

