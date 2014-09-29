require 'curses'
require_relative "../utils"

module Popmovies
  module Ui
    class View

      def initialize router, datas=nil
        @router = router
        @window = Curses::Window.new(0, 0, 0, 0)
        @window.keypad true
        @lines = 1
        @columns = 3
        @selected_index = 0
        @text = ""
        @datas = datas
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
        data_type = Utils.data_type @datas
        print "--> #{@datas.size} #{data_type}(s) found"

        @datas.each_with_index do |data,index|
          highlight = (index == @selected_index) ? true : false
          print " - #{data.title}", highlight
        end

        print "Key Up or Down to select a #{data_type}, then press enter"
        print @text, true

        input_handler @window.getch
      end

      def input_handler input
        input_handled = false
        if (input == Curses::KEY_DOWN) or (input == Curses::KEY_RIGHT)
          @text = "(next)"
          @selected_index += 1 if @selected_index < @datas.size-1
          input_handled = true
        elsif (input == Curses::KEY_UP) or (input == Curses::KEY_LEFT)
          @text = "(previous)"
          @selected_index -= 1 if @selected_index > 0
          input_handled = true
        elsif (input == 'q') or (input == 'Q')
          input_handled = false
          refresh
          close
          Kernel.abort
        # elsif (input == 'b') or (input == 'B')
          # input_handled = false
          # back_route_handler

          # refresh
          # close because it kill the window instance
        elsif (input == Curses::KEY_ENTER)
          refresh
          close
          input_handled = false
        end
        render if input_handled
      end

      def reset
        refresh
        clear
        @lines = 1
        @columns = 3
        @selected = @datas[@selected_index]
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
        Curses::refresh
        # return @selected
        route_handler
      end

    end
  end
end