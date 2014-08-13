require_relative '../views/home'

module Popmovies
  module Controllers
    class HomeController
      include Views

      def initialize
        @home_view = Home.new
      end

      def index
        @home_view.render
      end

    end
  end
end