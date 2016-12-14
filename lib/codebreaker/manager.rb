module Codebreaker
  class Manager
    def initialize
      @user_menu = Menu.new
      process_choice @user_menu.main_menu
    end

    def process_choice(choice)
      case choice
      when Menu::NEW_GAME
        start_game
      when Menu::SAVE_EXIT
        puts "We're going to save and exit the game!"
      when Menu::QUIT
        abort 'Bye'
      else
        raise 'Selected wrong choice!'
      end
    end

    private

    def start_game
      puts 'New game has been started!'
      current_game = Game.new
      print 'Your answer: '
      attempt_code = gets.chomp

      game_result = current_game.check_attempt(attempt_code)
      puts "Game result: #{game_result}"
    end


  end
end