require 'io/console'

module Codebreaker
  class Menu
    NEW_GAME = 1
    LOAD_SAVED = 2
    QUIT = 3
    SAVE_GAME = 4
    DO_NOT_SAVE_GAME = 5

    def main_menu
      menu_items = {
          '1' => :new_game,
          '2' => :load_saved_results,
          '3' => :quit,
      }

      while true
        puts '====================================='
        menu_items.each{ |key, value| puts "#{key} => #{format_item(value)}" }
        puts '====================================='
        print 'Make your choice: '

        user_choise = gets.chomp

        if menu_items.key?(user_choise)
          user_choise_label = menu_items[user_choise]
          puts format_item(user_choise_label)

          case user_choise_label
            when :new_game
              return NEW_GAME
            when :load_saved_results
              return LOAD_SAVED
            when :quit
              return QUIT
          end
        else
          puts "\n" + 'Please, enter correct value'
        end
      end
    end
    
    def save_game_menu
      puts 'Do you want to save game results? (yes/no)'
      while true
        user_data = gets.chomp.downcase
        if 'yes' == user_data
          puts 'your data is saved'
          return SAVE_GAME
        elsif 'no' == user_data
          return DO_NOT_SAVE_GAME
        else
          puts 'Enter \'yes\' or \'no\''
        end
      end
    end

    def get_player_name
      print 'Enter your name: '
      gets.chomp
    end

    private

    def format_item(item)
      item.to_s.capitalize.gsub('_', ' ')
    end

  end
end
