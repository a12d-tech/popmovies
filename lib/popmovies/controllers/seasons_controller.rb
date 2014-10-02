require_relative '../utils'
require_relative '../views/season_view'
require_relative '../models/season'

module Popmovies
  module Controllers
    class SeasonsController < Controller
      include Views
      include Models

      def initialize router
        @season_view = SeasonView.new router
      end

      def index tv_show
        @seasons = fetch_datas(tv_show.url,Config::WEB[:seasons_css_selector]) do |html_tags|
          html_tags.map { |season| Season.new(season.text, season['href']) }
        end
        @season_view.update @seasons
        @season_view.render
      end

    end
  end
end
