require_relative '../ui/view'

module Popmovies
  module Views
    class HomeView
      
      BANNER = %Q[
88""Yb  dP"Yb  88""Yb 8b    d8  dP"Yb  Yb    dP 88 888888 .dP"Y8
88__dP dP   Yb 88__dP 88b  d88 dP   Yb  Yb  dP  88 88__   `Ybo."
88"""  Yb   dP 88"""  88YbdP88 Yb   dP   YbdP   88 88""   o.`Y8b
88      YbodP  88     88 YY 88  YbodP     YP    88 888888 8bodP'
                                                                
                                                                
                                            by gntics]

      def initialize
        @banner_parts = BANNER.split("\n")
        banner_width = @banner_parts[1].length
        banner_height = @banner_parts.size

        @window =
          Curses::Window.new(
            banner_height,
            banner_width,
            (Curses.lines - banner_height + 3) / 2,
            (Curses.cols - banner_width) / 2
          )

        @window.keypad(true)
      end

      def render
        display_banner
        Curses.refresh
      end

      private

      def display_banner
        @banner_parts.each { |line| @window.addstr(line) }

        catch_input_and_clear
      end

      def catch_input_and_clear
        @window.refresh
        @window.getch
        @window.close
      end

    end
  end
end
