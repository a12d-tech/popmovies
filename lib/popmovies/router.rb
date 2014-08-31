require_relative 'controllers/home_controller'
require_relative 'controllers/tv_shows_controller'
require_relative 'controllers/seasons_controller'

module Popmovies
  class Router
    include Controllers

    def initialize
      @home_controller = HomeController.new self
      @tv_shows_controller = TvShowsController.new self
      @seasons_controller = SeasonsController.new self
      @tv_show = nil
    end

    def get action, model=nil
      case action
      when :home
        home
      when :tv_shows
        tv_shows_menu
      when :seasons
        @tv_show = model
        seasons_menu
      # when :episodes
      #   @season = model
      #   episodes_menu
      end
    end

    def home
      @home_controller.index
    end

    def tv_shows_menu
      @tv_shows_controller.index
    end

    def seasons_menu
      @seasons_controller.index @tv_show
    end

    # def episodes_menu
      
    # end

  end
end