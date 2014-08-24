require 'json'

require_relative '../utils'
require_relative '../views/tv_show_view'
require_relative '../models/tv_show'

require_relative "../application"

module Popmovies
  module Controllers
    class TvShowsController
      include Views
      include Models

      TV_SHOWS_CSS_SELECTOR = "div.sidebarborder div.sidebar-right ul li.cat-item a"

      def initialize
        @tv_shows = fetch_datas
        @tv_show_view = TvShowView.new @tv_shows
      end

      def index
        @tv_show_view.render
      end

      def fetch_datas
        # TODO : test it !!
        # check the resule of fetch_html_page and page.css
        # depends on Exception thrown by nokogiri and open-uri on Utils class
        page = Utils.fetch_html_page Application.WEBSITE_URL
        html_tv_shows = page.css TV_SHOWS_CSS_SELECTOR

        tv_shows = []
        html_tv_shows.each do |show|
          tv_show_title = show.text
          tv_show_url = show['href']
          tv_shows << TvShow.new(tv_show_title, tv_show_url)
        end
        return tv_shows
      end

      # "American Horror Story"=>"http://streaming-series.org/american-horror-story/"
      # http://streaming-series.org/
      #   american-horror-story/ => seasons list
    end
  end
end