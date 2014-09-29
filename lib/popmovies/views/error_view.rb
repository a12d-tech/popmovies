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
        begin
          display
        ensure
          # @window.close
        end
      end

      def display
        @window.addstr @message
        @window.refresh
        @window.getch
      end
      
    end
  end
end