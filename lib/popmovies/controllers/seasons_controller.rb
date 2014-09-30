require_relative '../utils'
require_relative '../views/season_view'
require_relative '../models/season'

module Popmovies
  module Controllers
    class SeasonsController < Controller
      include Views
      include Models

      SEASONS_CSS_SELECTOR = "div.filmborder div.filmcontent div.moviefilm div.movief a"

      def initialize router
        super()
        @season_view = SeasonView.new router
      end

      def index tv_show
        @seasons = fetch_datas(tv_show.url,SEASONS_CSS_SELECTOR){
          seasons = []
          @html_selected_tags.each do |season|
            season_title = season.text
            season_url = season['href']
            seasons << Season.new(season_title, season_url)
            tv_show.seasons << seasons
          end
         @datas = seasons
        }
        @season_view.update @seasons
        @season_view.render
      end

    end
  end
end