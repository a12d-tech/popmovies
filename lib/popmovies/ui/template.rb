require 'curses'

module Popmovies
  module Ui
    class Template

      def initialize
        Curses.init_screen
        Curses.crmode
        Curses.stdscr.keypad true
      end

      def close
        Curses.close_screen
      end

    end
  end
end
