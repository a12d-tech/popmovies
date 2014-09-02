require_relative "../ui/view"

module Popmovies
  module Views
    class SeasonView < Ui::View

      def update seasons
        @datas = seasons
        @selected = @datas[@selected_index]
      end

      def route_handler
        @router.get :episodes, @selected
      end

    end
  end
end