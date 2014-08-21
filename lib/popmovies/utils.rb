require 'nokogiri'
require 'open-uri'

module Popmovies
  class Utils

    def self.fetch_html_page url
      page = Nokogiri::HTML(open(url)) do |config|
        config.nonet
      end
    end

  end
end