require 'nokogiri'
require 'open-uri'

module Popmovies
  class Utils

    def self.fetch_html_page(url)
      page = Nokogiri::HTML(open(url)) do |config|
          config.nonet
      end
    rescue SocketError => e
      ConnectionError.new.handle
    end

    def self.data_type(datas)
      datas.empty? ? nil : datas.first.class.name.split("::").last
    end

  end
end
