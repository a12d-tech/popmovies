require 'curses'

module Popmovies
  module Ui
    class Template

      def initialize
        Curses.init_screen
        Curses.start_color
        Curses.crmode
        Curses.stdscr.keypad true
        Curses.noecho
      end

      def close
        Curses.close_screen
      end

    end
  end
end
