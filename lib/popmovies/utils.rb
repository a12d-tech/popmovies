require 'nokogiri'
require 'open-uri'

module Popmovies
  class Utils

    def self.fetch_html_page url
      begin
        page = Nokogiri::HTML(open(url)) do |config|
          config.nonet
        end
      rescue Exception => e
        false
      end
    end

  end
end