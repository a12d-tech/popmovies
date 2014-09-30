require 'curses'

module Popmovies
  module Views
    class ErrorView
      include Curses

      def initialize message
        @message = message
        width = message.length + 6
        @window = Window.new(5, width,
             (lines - 5) / 2, (cols - width) / 2)
      end

      def show
        @window.addstr @message
        @window.refresh
        @window.getch
        @window.close
      end

    end
  end
end