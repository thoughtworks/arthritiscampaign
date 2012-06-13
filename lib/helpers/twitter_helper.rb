module Sinatra
  module TwitterHelper

    def share_to_twitter_url(photo_url)
      "https://twitter.com/intent/tweet?source=webclient&text=#{twitter_message(photo_url)}&via=ArthritisSoc"
    end

    private

    def twitter_message(photo_url)
      URI.escape("Please support 4.6 million Canadians living with arthritis! Watch the video and share the infographic! http://www.goriete.com/page.aspx?pid=6324")
    end
  end

  helpers TwitterHelper
end
