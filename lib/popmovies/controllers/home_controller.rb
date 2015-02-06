require_relative '../views/home_view'

module Popmovies
  module Controllers
    class HomeController < Controller
      include Views

      def initialize
        super
        @home_view = HomeView.new
      end

      def render
        @home_view.render
        @router.trigger(:rendered)
      end

    end
  end
end
