module Popmovies
  module Views
    class ErrorView
      include Curses

      def initialize(message)
        width = message.length + 6
        @message = message

        @window = Window.new(5, width, (lines - 5) / 2, (cols - width) / 2)
        @window.keypad(true)
      end

      def render
        @window.addstr(@message)

        @window.refresh
        @window.getch
        @window.close
      end

    end
  end
end
