require_relative '../utils'
require_relative '../views/tv_show_view'
require_relative '../models/tv_show'

module Popmovies
  module Controllers
    class TvShowsController
      include Views
      include Models

      WEBSITE_URL = "http://streaming-series.org/"

      TV_SHOWS_CSS_SELECTOR = "div.sidebarborder div.sidebar-right ul li.cat-item a"

      def initialize router
        @tv_shows = fetch_datas
        @tv_show_view = TvShowView.new router, @tv_shows
      end

      def index
        @tv_show_view.render
      end

      def fetch_datas
        # TODO : test it !!
        # check the resule of fetch_html_page and page.css
        # depends on Exception thrown by nokogiri and open-uri on Utils class
        page = Utils.fetch_html_page WEBSITE_URL
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