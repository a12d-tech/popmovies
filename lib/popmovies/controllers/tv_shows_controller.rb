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
        super()
        # call fecth_data(url,css_selector){ &block }
        @tv_shows = fetch_datas(Config::WEB[:endpoint],Config::WEB[:tv_shows_css_selector]){
          tv_shows = []
          @html_selected_tags.each do |show|
            tv_show_title = show.text
            tv_show_url = show['href']
            tv_shows << TvShow.new(tv_show_title, tv_show_url)
          end
          # can not insert a return here so we go through @datas
          # which is returned at the end of fetch_data method
          @datas = tv_shows
        }
        @tv_show_view = TvShowView.new router, @tv_shows
      end

      def index
        @tv_show_view.render
      end

    end
  end
end