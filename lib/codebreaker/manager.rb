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
      when Menu::LOAD_SAVED
        load_saved_games
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
        @current_game.game_win
        process_save_request
      end
    end

    def game_over
      puts ''
      puts '++++++++++++++'
      puts '| Game over! |'
      puts '++++++++++++++'
      @current_game.game_lost
      process_choice @user_menu.main_menu
    end

    def take_hint
      if @current_game.hint_available?
        puts "First number: #{@current_game.take_hint}"
      else
        puts 'You\'ve already taken a hint!'
      end
    end

    def process_save_request
      if Menu::SAVE_GAME == @user_menu.save_game_menu
        load_data_manipulator.add_game(@user_menu.get_player_name, @current_game.game_win?, @current_game.attempts_used, !@current_game.hint_available?)
      end
      process_choice @user_menu.main_menu
    end

    def load_saved_games
      display_saved_games load_data_manipulator.return_all_data
      process_choice @user_menu.main_menu
    end

    def load_data_manipulator
      @data_manipulator = DataManipulator.new unless defined? @data_manipulator
      @data_manipulator
    end

    def display_saved_games(games)
      if games.length.zero?
        puts 'There are no data for display'
      else
        col_size = 20
        puts make_separator_line(col_size, 5)
        puts '|' + 'User name'.ljust(col_size) + '|' + 'Game status'.ljust(col_size) + '|' + 'Attempts'.ljust(col_size) +
          '|' + 'Hint'.ljust(col_size) + '|' + 'Date'.ljust(col_size) + '|'
        puts make_separator_line(col_size, 5)
        games.each do |game|
          puts "|#{game[:user_name].ljust(col_size)}|#{game[:game_status].ljust(col_size)}|#{game[:attempts_count].to_s.ljust(col_size)}|#{game[:hint].ljust(col_size)}|#{game[:date].ljust(col_size)}|"
        end
        puts make_separator_line(col_size, 5)
      end
    end

    def make_separator_line(col_size, col_count)
      ' ' + ('-' * ((col_size * col_count) + (col_count - 1))) + ' '
    end
  end
end