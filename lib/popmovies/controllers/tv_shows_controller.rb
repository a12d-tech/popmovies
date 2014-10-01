require_relative '../utils'
require_relative '../views/tv_show_view'
require_relative '../models/tv_show'
require_relative '../error'
require_relative 'controller'

module Popmovies
  module Controllers
    class TvShowsController < Controller
      include Views
      include Models

      def initialize router
        # call fecth_data(url,css_selector){ &block }
        @tv_shows = fetch_datas(Config::WEB[:endpoint],Config::WEB[:tv_shows_css_selector]) do |html_tags|
          html_tags.map { |show| TvShow.new(show.text,show['href']) }
        end
        @tv_show_view = TvShowView.new router, @tv_shows
      end

      def index
        @tv_show_view.render
      end

    end
  end
end