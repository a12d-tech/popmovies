require_relative '../views/tv_show_view'
require_relative '../models/tv_show'

module Popmovies
  module Controllers
    class TvShowsController < Controller
      include Views
      include Models
      include Config

      URL          = WEB[:endpoint]
      CSS_SELECTOR = WEB[:tv_shows_css_selector]

      def initialize
        super

        @tv_shows =
          fetch_datas(URL, CSS_SELECTOR) { |html_tags| parseHtml(html_tags) }

        @tv_show_view = TvShowView.new(@tv_shows)
      end


      def render
        @tv_show_view.render
        @router.trigger(:selected, @tv_show_view.selected)
      end

      private

      def parseHtml(html_tags)
        html_tags.map { |show| TvShow.new(show.text, show['href']) }
      end

    end
  end
end
