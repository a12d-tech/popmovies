require_relative '../utils'
require_relative '../views/tv_show_view'
require_relative '../models/tv_show'
require_relative '../error'

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

      private

      def fetch_datas
        begin
          page = Utils.fetch_html_page WEBSITE_URL
          html_tv_shows = page.css TV_SHOWS_CSS_SELECTOR

          raise RemoteError, "It seems broken! Sorry" if html_tv_shows.empty?

          tv_shows = []
          html_tv_shows.each do |show|
            tv_show_title = show.text
            tv_show_url = show['href']
            tv_shows << TvShow.new(tv_show_title, tv_show_url)
          end
          return tv_shows

        rescue RemoteError, ConnectionError => e
          e.handle
        end
      end

    end
  end
end