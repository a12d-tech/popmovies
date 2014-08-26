module Popmovies
  module Models
    class SeasonView

      def initialize
        @window = Curses::Window.new(0, 0, 0, 0)
        @window.keypad true
        @lines = 1
        @columns = 3
      end

      def render tv_show
        @window.setpos @lines, @columns
        # print "--> #{@tv_shows.size} tv shows found"
        @window.addstr "season view"
        @window.getch
        Curses::refresh
      end

    end
  end
end