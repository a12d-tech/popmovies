module Popmovies
  module Ui
    class View

      attr_accessor :selected

      def initialize(datas = nil)
        screen_height = Curses.stdscr.maxy
        cmd_window_height = 4
        window_height = screen_height - cmd_window_height

        @cmd_window = Curses::Window.new(cmd_window_height, 0, window_height, 0)

        @window = Curses::Window.new(window_height, 0, 0, 0)
        @window.scrollok(true)
        @window.idlok(true)
        @window.keypad(true)
        
        @cursor_line_pos = 1
        @cursor_column_pos = 3

        @selected_index = 0
        @selected = nil

        @datas = datas

        @visible_rows = 0
        @more = false
      end

      def render
        Curses.clear
        display
        Curses.refresh
      end

      def populate_with(datas)
        @datas = datas
        @selected = @datas[@selected_index]
      end

      protected

      def display
        @visible_rows = @window.maxy - 4
        @more = (@datas.size > @visible_rows) ? true : false

        init_cmd_win
        init_main_win
        display_datas
        input_handler
      end

      def write_line(window, line, column, text, highlight = false)
        style = highlight ? Curses::A_BOLD : Curses::A_NORMAL

        window.attrset(style)
        window.setpos(line, column)
        window.addstr(" - #{text}")
      end

      def init_cmd_win
        data_type = Utils.data_type(@datas)

        @cmd_window.clear
        @cmd_window.box("|", "-")

        write_line(
          @cmd_window,
          1,
          3,
          "Key Up or Down to select, then press ENTER ( press q to exit )"
        )
        write_line(
          @cmd_window,
          2,
          3,
          "#{@datas.size} #{data_type}(s) found",
          true
        )

        @cmd_window.refresh
      end

      def init_main_win
        @window.clear
      end

      def display_datas

        if @more
          data_list = @datas[0..@visible_rows]
          more = true
        else
          data_list = @datas
        end

        data_list.each_with_index do |data,index|
          highlight = (index == @selected_index) ? true : false
          write_line(
            @window,
            @cursor_line_pos,
            @cursor_column_pos,
            data.title,
            highlight
          )
          @cursor_line_pos += 1
        end

        @cursor_line_pos = 1
        @window.setpos(@cursor_line_pos, @cursor_column_pos)
      end

      def scroll_down
        if @selected_index < @datas.length-1
          if @selected_index >= @visible_rows
            @selected_index += 1
            if @cursor_line_pos <= @visible_rows
              @cursor_line_pos +=1
            else
              @window.scrl(1)
            end
          else
            @cursor_line_pos += 1
            @selected_index += 1
          end
          write_line(
            @window,
            @cursor_line_pos - 1,
            @cursor_column_pos,
            @datas[@selected_index - 1].title,
            false
          )
          write_line(
            @window,
            @cursor_line_pos,
            @cursor_column_pos,
            @datas[@selected_index].title,
            true
          )
        end
      end

      def scroll_up
        if @selected_index > 0
          if @selected_index > @visible_rows
            @selected_index -= 1
            if @cursor_line_pos > 0
              @cursor_line_pos -= 1
            else
              @window.scrl(-1)
            end
          else
            if @cursor_line_pos > 0
              @cursor_line_pos -= 1
            else
              @window.scrl(-1)
            end
            @selected_index -= 1
          end
          write_line(
            @window,
            @cursor_line_pos + 1,
            @cursor_column_pos,
            @datas[@selected_index + 1].title,
            false
          )
          write_line(
            @window,
            @cursor_line_pos,
            @cursor_column_pos,
            @datas[@selected_index].title,
            true
          )
        end
      end

      def input_handler
        loop do
          input = @window.getch
          case input
          when Curses::KEY_DOWN
            scroll_down
          when Curses::KEY_UP
            scroll_up
          when 10 # KEY_ENTER not working !!?
            @selected = @datas[@selected_index]
            close
            break
          when ?q
            Kernel.exit
            close
            break
          end
        end
      end

      def close
        @window.refresh
        @window.close
        @cmd_window.refresh
        @cmd_window.close
      end

    end
  end
end
