require_relative '../ui/view'

module Popmovies
  module Views
    class TvShowView < Ui::View

      def route_handler
        @router.get :seasons, @selected
      end

    end
  end
end