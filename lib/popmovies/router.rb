require_relative 'controllers/home_controller'
require_relative 'controllers/tv_shows_controller'
require_relative 'controllers/seasons_controller'
require_relative 'controllers/episodes_controller'

module Popmovies
  class Router
    include Controllers

    def initialize
      @home_controller = HomeController.new self
      @tv_shows_controller = TvShowsController.new self
      @seasons_controller = SeasonsController.new self
      @episodes_controller = EpisodesController.new self
      @tv_show_selected = nil
      @season_selected = nil
    end

    def get action, model=nil
      case action
      when :home
        home
      when :tv_shows
        tv_shows_menu
      when :seasons
        @tv_show_selected = model
        seasons_menu
      when :episodes
        @season_selected = model
        # maybe we dont need model argument because we have @tv_show_selected.seasons
        episodes_menu
      end
    end

    def home
      @home_controller.index
    end

    def tv_shows_menu
      @tv_shows_controller.index
    end

    def seasons_menu
      @seasons_controller.index @tv_show_selected
    end

    def episodes_menu
      @episodes_controller.index @season_selected
    end

  end
end