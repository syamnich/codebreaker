module Codebreaker
  class Game

    attr_reader :attempts_count
    TOTAL_COUNT = 10

    def initialize
      @secret_code = ""      
    end

    def start
      @secret_code = generate_code
      @attempts_count = TOTAL_COUNT
      @hint = nil
    end
    
    def check(guess)
      return "You don't have attempts" if @attempts_count.zero?
      @attempts_count -= 1
      return "Invalid guess format" if !guess.match(/^[1-6]{4}$/) && !guess.match(/^\?$/)
      return hint if guess.match(/^\?$/)
      return "++++" if guess == @secret_code
      
      result = ""
      index = []
      code_guess = str_to_array(guess)
      secret_code = str_to_array(@secret_code)
      code_guess.each_index { |i| result << "+" && index << i if code_guess[i]==secret_code[i] }
      
      delete_index(code_guess, index)
      delete_index(secret_code, index)
            
      code_guess.each { |i| result << "-" if secret_code.include?(i)}
      result
    end

    def hint
      return @hint if @hint
      @hint = "****"
      ind = rand(4)
      @hint[ind] = @secret_code[ind]
      @hint
    end

    def turns
      TOTAL_COUNT - @attempts_count
    end
      
    
    private

    def generate_code
      (1..4).map { rand(1..6) }.join
    end

    def str_to_array(str)
      str.chars.map { |i| i.to_i }
    end

    def delete_index(array, index)
      array.map!.with_index { |item, i| item unless index.include?(i) }.compact!
    end
  end
end