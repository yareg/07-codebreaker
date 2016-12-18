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
        puts 'We\'re going to save and exit the game!'
      when Menu::QUIT
        quit
      else
        raise 'Selected wrong choice!'
      end
    end

    private

    def start_game
      puts 'New game has been started!'
      puts 'You should enter number between 1111 and 6666, "h" for help, or "q" for exit'
      @current_game = Game.new
      while @current_game.attempt_available?
        print 'Your answer: '
        answer = gets.chomp.downcase
        case answer
        when 'h'
          take_hint
        when 'q'
          quit
        when /^[1-6]{4}$/
          @current_game.use_attempt
          try_guess answer
        else
          puts 'Incorrect answer!'
        end
      end
      game_over
    end

    def quit
      abort 'Bye'
    end

    def try_guess(answer)
      game_result = @current_game.check_attempt(answer)
      puts "Game result: #{game_result}"
      if '++++' == game_result
        puts ''
        puts '++++++++++++++++++++++'
        puts '| Congrats! You win! |'
        puts '++++++++++++++++++++++'
        process_choice @user_menu.main_menu
      end
    end

    def game_over
      puts ''
      puts '++++++++++++++'
      puts '| Game over! |'
      puts '++++++++++++++'
      process_choice @user_menu.main_menu
    end

    def take_hint
      if @current_game.hint_available?
        puts "First number: #{@current_game.take_hint}"
      else
        puts 'You\'ve already taken a hint!'
      end
    end
  end
end