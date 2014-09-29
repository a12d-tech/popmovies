require 'nokogiri'
require 'open-uri'
require_relative "views/error_view"

module Popmovies
  class Utils
    include Views

    def self.fetch_html_page url
      begin
        page = Nokogiri::HTML(open(url)) do |config|
          config.nonet
        end
      rescue SocketError => e
        ErrorView.new("Check your internet connection!").show
        # puts e.message
        # puts "Check your internet connection!"
        Kernel.abort
      end
    end

    def self.data_type datas
      #return smthing like Popmovies::Models::Season
      datas.empty? ? nil : datas.first.class.name.split("::").last
    end
  end
end