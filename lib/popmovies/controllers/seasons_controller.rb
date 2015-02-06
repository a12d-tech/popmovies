require_relative '../views/season_view'
require_relative '../models/season'

module Popmovies
  module Controllers
    class SeasonsController < Controller
      include Views
      include Models
      include Config

      CSS_SELECTOR = WEB[:seasons_css_selector]

      def initialize
        super
        @season_view = SeasonView.new
      end

      def render(tv_show)
        @seasons =
          fetch_datas(tv_show.url, CSS_SELECTOR) { |html_tags| parseHtml(html_tags)}

        @season_view.populate_with(@seasons)
        @season_view.render

        @router.trigger(:selected, @season_view.selected)
      end

      private

      def parseHtml(html_tags)
        html_tags.map { |season| Season.new(season.text, season['href']) }
      end

    end
  end
end
