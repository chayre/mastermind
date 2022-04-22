# This module defines valid input, checks if the game is still good to continue, and stops it when there is a winner.
module Rules
    VALID = ['1', '2', '3', '4'].freeze
    
    def game_on?
      if @feedback.all? { |i| i == 'X' } && @feedback.length > 1
        @output_statement = 'Game over; code broken. Codebreaker wins.'
        false
      elsif @round > 11
        @output_statement = 'Game over; board full. Codemaker wins.'
        false
      else
        true
      end
    end
  
    def rules
      puts 'The code is a four digit number. Each digit can be 1, 2, 3, or 4. The codebreaker must guess the code within 12 rounds or the CODEMAKER wins.'
    end
  end