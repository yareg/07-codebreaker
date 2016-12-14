require 'io/console'

module Codebreaker
  class Menu
    NEW_GAME = 1
    SAVE_EXIT = 2
    QUIT = 3

    def main_menu
      @menu_items = {
          '1' => :new_game,
          '2' => :save_and_exit,
          '3' => :quit,
      }

      while true
        puts '====================================='
        @menu_items.each{ |key, value| puts "#{key} => #{format_item(value)}" }
        puts '====================================='
        print 'Make your choice: '

        user_choise = read_char

        if @menu_items.key?(user_choise)
          user_choise_label = @menu_items[user_choise]
          puts format_item(user_choise_label)


          case user_choise_label
            when :new_game
              return NEW_GAME
            when :save_and_exit
              return SAVE_EXIT
            when :quit
              return QUIT
          end
        else
          puts "\n" + 'Please, enter correct value'
        end
      end
    end

    private

    def read_char
      STDIN.echo = false
      STDIN.raw!

      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
    end

    def format_item(item)
      item.to_s.capitalize.gsub('_', ' ')
    end

  end
end
