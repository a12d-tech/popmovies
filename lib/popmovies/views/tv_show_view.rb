require_relative '../ui/view'

module Popmovies
  module Views
    class TvShowView # < Ui::View

      def initialize tv_shows
        @window = Curses::Window.new(0, 0, 0, 0)
        @window.keypad true
        @lines = 1
        @columns = 3
        @tv_shows = tv_shows
        @selected_index = 0
        @selected = @tv_shows[@selected_index]
        @text = ""
      end

      def print msg, highlight=false
        if highlight
          @window.attrset Curses::A_BOLD
          @window.setpos @lines, @columns+2
        else
          @window.setpos @lines, @columns
        end

        @window.addstr msg
        @lines += 1

        if highlight
          @window.attrset Curses::A_NORMAL
          @window.setpos @lines, @columns-2
        end
      end

      def display
        @window.setpos @lines, @columns
        print "--> #{@tv_shows.size} tv shows found"

        @tv_shows.each_with_index do |tv_show,index|
          highlight = (index == @selected_index) ? true : false
          print "#{index+1} - #{tv_show.title}", highlight
        end

        print "Key Up or Down to select a tv show, then press enter"
        print @text, true

        inputHandler @window.getch
      end

      def inputHandler input
        inputHandled = false
        if (input == Curses::KEY_DOWN) or (input == Curses::KEY_RIGHT)
          @text = "(next)"
          @selected_index += 1 if @selected_index < @tv_shows.size-1
          inputHandled = true
        elsif (input == Curses::KEY_UP)  or (input == Curses::KEY_LEFT)
          @text = "(previous)"
          @selected_index -= 1 if @selected_index > 0
          inputHandled = true
        elsif (input == Curses::KEY_ENTER)
          refresh
          close
          inputHandled = false
        end
        render if inputHandled
      end

      def reset
        refresh
        clear
        @selected = @tv_shows[@selected_index]
        @lines = 1
        @columns = 3
      end

      def clear
        @window.clear
      end

      def refresh
        @window.noutrefresh
      end

      def close
        @window.close
      end

      def render
        reset
        display
        Curses.refresh
        return @selected
      end

    end
  end
end