require_relative "../ui/view"

module Popmovies
  module Models
    class SeasonView < Ui::View

      def update seasons
        @datas = seasons
        @selected = @datas[@selected_index]
      end

    end
  end
end