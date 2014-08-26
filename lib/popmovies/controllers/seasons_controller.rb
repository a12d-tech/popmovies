require_relative '../utils'
require_relative '../views/season_view'
require_relative '../models/season'

module Popmovies
  module Controllers
    class SeasonsController
      include Views
      include Models

      SEASONS_CSS_SELECTOR = "div.filmborder div.filmcontent div.moviefilm div.movief a"

      def initialize
        @season_view = SeasonView.new
      end

      def index tv_show
        @season_view.render tv_show
      end
    end
  end
end