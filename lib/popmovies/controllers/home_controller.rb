require_relative '../views/home_view'

module Popmovies
  module Controllers
    class HomeController
      include Views

      def initialize router
        @home_view = HomeView.new router
      end

      def index
        @home_view.render
      end

    end
  end
end