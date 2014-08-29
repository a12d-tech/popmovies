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
        # TODO : see what kind of exception it returns
        # if no internet connection found
        # to exit program with the proper message
        # check if no internet connection
      end
    end

    def self.data_type datas
      if datas.empty?
        nil
      else
        datas.first.class.name.split("::").last #return smthing like Popmovies::Models::Season
      end
    end
  end
end