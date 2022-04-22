# frozen_string_literal: true

require_relative 'mastermind'

# Class for the breaker gamemode of Mastermind in which the player must guess the computer-generated code
class Breaker < Mastermind
  # Calculate the type of match and number of each type by iterating through the code and guesss
  def play
    rules
    computer_generate_code
    while game_on?
      human_guess
      generate_feedback(@guess, @code)
      record_guess_and_feedback
      show_board
      puts 'What is your next guess?' if game_on? 
    end
    puts
    puts @output_statement
    puts
  end
  
  def computer_generate_code
    @code = Array.new(4) { rand(1..4).to_s }
  end
  
  def human_guess
    @round += 1
    if @round < 2
      puts "You're the codebreaker. After your guess, we'll display how many digits are correct place and value (X), how many are only correct value (O), and how many are neither (-). What is your guess?"
    end
    @guess = $stdin.gets.chomp.to_s.chars
    until @guess.all? { |i| VALID.include?(i) } && @guess.length == 4
      puts 'Please input a 4 digit code using only the numbers 1, 2, 3, and 4.'
      @guess = $stdin.gets.chomp.to_s.chars
    end
  end
end