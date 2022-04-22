# frozen_string_literal: true

require_relative 'mastermind'

#Class for the creator gamemode of Mastermind in which the computer must crack the player-created code
class Creator < Mastermind
  def play
    rules
    human_generate_code
    setup
    record_guess_and_feedback
    show_start
    while game_on?
      compare_guess_and_feedback
      record_guess_and_feedback
      @round += 1
      show_board
    end
    puts
    puts @output_statement
    puts
  end

  def show_start
    puts "\n"
    puts '    ┌─────────┬───────┬───────┐'
    puts "    │ ROUND 1 │ GUESS │ FDBAK │"
    puts '    └─────────┼───────┼───────┤'
    puts "              │  #{@guess[0]}#{@guess[1]}#{@guess[2]}#{@guess[3]}#{@guess[4]} │  #{@feedback[0]}#{@feedback[1]}#{@feedback[2]}#{@feedback[3]} │"
    puts '              └───────┴───────┘'
    puts "\n"
  end
  
  def human_generate_code
    puts "You're the codemaker. Create a four-digit code for the computer to break."
    puts 'Type your four-digit code; use digits 1 through 4. Order matters!'
    input = $stdin.gets.chomp.to_s.chars
    until input.all? { |i| VALID.include?(i) } && input.length == 4
      puts 'Please input a 4 digit code using only the numbers 1, 2, 3, and 4.'
      input = $stdin.gets.chomp.to_s.chars
    end
    @code = input
  end
  
  def computer_guess
    @round += 1
    @guess = Array.new(4) { rand(1..4).to_s }
  end
end
