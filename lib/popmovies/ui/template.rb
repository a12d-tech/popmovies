require 'curses'

module Popmovies
  module Ui
    class Template

      def initialize
        Curses.init_screen
        Curses.start_color
        #Curses.init_pair(0, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
        #Curses.init_pair(1, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
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
