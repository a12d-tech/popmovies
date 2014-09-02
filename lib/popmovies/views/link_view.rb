module Popmovies
  module Views
    class LinkView < Ui::View

      def update links
        @datas = links
        @selected = @datas[@selected_index]
      end

      def route_handler
        Kernel.abort
      end

    end
  end
end