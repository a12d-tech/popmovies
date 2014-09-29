require_relative '../ui/view'

module Popmovies
  module Views
    class TvShowView < Ui::View

      def route_handler
        @router.get :seasons, @selected
      end

      def back_route_handler
        # do nothing
        # @router.get :home
        # return
      end

    end
  end
end