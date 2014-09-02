require_relative "../ui/view"

module Popmovies
  module Views
    class EpisodeView < Ui::View

      def update episodes
        @datas = episodes
        @selected = @datas[@selected_index]
      end

      def route_handler
        Kernel.abort
      end

    end
  end
end