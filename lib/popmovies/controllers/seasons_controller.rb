require_relative '../utils'
require_relative '../views/season_view'
require_relative '../models/season'

module Popmovies
  module Controllers
    class SeasonsController
      include Views
      include Models

      SEASONS_CSS_SELECTOR = "div.filmborder div.filmcontent div.moviefilm div.movief a"

      def initialize router
        @season_view = SeasonView.new router
      end

      def index tv_show
        @seasons = fetch_datas tv_show
        @season_view.update @seasons
        @season_view.render
      end

      def fetch_datas tv_show
        # TODO : test it !!
        # check the resule of fetch_html_page and page.css
        # depends on Exception thrown by nokogiri and open-uri on Utils class
        page = Utils.fetch_html_page tv_show.url
        html_seasons = page.css SEASONS_CSS_SELECTOR

        seasons = []
        html_seasons.each do |season|
          season_title = season.text
          season_url = season['href']
          seasons << Season.new(season_title, season_url)
          tv_show.seasons << seasons
        end
        return seasons
      end

    end
  end
end