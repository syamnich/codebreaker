require "codebreaker/game"

module Codebreaker
  class GameInterface
		
		
    def initialize
      @game = Game.new
    end

    def run
      @game.start
      puts "Welcome to Codebreaker Game"
      while @game.attempts_count > 0
      	puts "Enter guess or ? for hint"
      	answer = gets.chomp
      	guess = @game.check(answer)
        puts guess
        if guess == "++++"
          puts "You won!"
          restart
        elsif @game.attempts_count.zero?
          puts "You lose!"
          restart
        end
      end
    end

    private
    
    def restart
      puts "Do you want to play again? y/n"
      answer = gets.chomp
      if answer == "y"
        run
      elsif answer == "n"
        save
      else 
        puts "Please, enter y or n"
      end
    end

    def save
      puts "Do you want to save your score? y/n"
      answer = gets.chomp
      if answer == "y"
        puts "Enter your name"
        username = gets.chomp
        save_to_file("score.txt", username)
      end
    end

    def save_to_file(filename, username)
      File.open(filename, 'a') do |file|
      file.puts "#{username};#{@game.turns};"
      end
    end
  end
end
  