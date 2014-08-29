require 'curses'
require_relative "../utils"
require_relative "../application"

module Popmovies
  module Ui
    class View

      def initialize datas=nil
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
        print "--> #{@datas.size} #{data_type} found"

        @datas.each_with_index do |data,index|
          highlight = (index == @selected_index) ? true : false
          #highlight = false
          print " - #{data.title}", highlight
        end

        print "Key Up or Down to select a #{data_type}, then press enter"
        print @text, true

        inputHandler @window.getch
      end

      def inputHandler input
        inputHandled = false
        if (input == Curses::KEY_DOWN) or (input == Curses::KEY_RIGHT)
          @text = "(next)"
          @selected_index += 1 if @selected_index < @datas.size-1
          inputHandled = true
        elsif (input == Curses::KEY_UP) or (input == Curses::KEY_LEFT)
          @text = "(previous)"
          @selected_index -= 1 if @selected_index > 0
          inputHandled = true
        elsif (input == 'q') or (input == 'Q')
          #inputHandled = false
          Application.exit
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
        return @selected
      end

    end
  end
end