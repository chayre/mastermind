# frozen_string_literal: true

require_relative 'algorithm'
require_relative 'rules'

# Placeholder comment
class Mastermind
  attr_accessor :mode, :round, :board, :code, :guess, :feedback, :set, :gold_file_guess, :gold_file_feedback, :bad_index

  include Algorithm 
  include Rules

  def initialize
    @round = 0
    @board = ['']
    @code = 0
    @guess = 0
    @feedback = []
    @output_statement = ''
  end

  def record_guess_and_feedback
    @board.concat ["             │  #{@guess[0]}#{@guess[1]}#{@guess[2]}#{@guess[3]}#{@guess[4]} │  #{@feedback[0]}#{@feedback[1]}#{@feedback[2]}#{@feedback[3]} │\n"]
  end

  def show_board
    puts "\n"
    puts '    ┌─────────┬───────┬───────┐'
    puts "    │ ROUND #{@round} │ GUESS │ FDBAK │"
    puts '    └─────────┼───────┼───────┤'
    puts @board.join(' ')
    puts '              └───────┴───────┘'
    puts "\n"
  end

  # Construct the feedback array by counting how many matches there are for each condition and adding the appropriate symbol to the feedback array
  def generate_feedback(guess_candidate, code_candidate)
    @feedback = []
    matches = calculate_matches("Exact", guess_candidate, code_candidate)
    near_matches = calculate_matches("Near", guess_candidate, code_candidate)
    matches.times do
      @feedback.push('X')
    end
    near_matches.times do
      @feedback.push('O')
    end 
    [(4 - matches - near_matches), 0].max.times do
      @feedback.push('-')
    end
  end
  
  def calculate_matches(command, guess_candidate, code_candidate)
    correct_place_and_value = 0
    correct_value_only = 0
    # Make two clones on the input so 1. we do not alter the input 2. when we alter the first clone, it does not affect our matching algorithm
    temp_code = code_candidate.clone.join().chars
    temp_code_unaltered = code_candidate.clone.join().chars
    temp_guess = guess_candidate.clone.join().chars
    temp_guess_unaltered = guess_candidate.clone.join().chars
    # Check for an exact match; if found, record it and alter the clone array to get rid of it (so it isn't double-counted in next step)
    temp_guess_unaltered.each_with_index do |i, a|
      if temp_guess_unaltered[a] == temp_code_unaltered[a]
        correct_place_and_value += 1
        temp_code[a] = 0
        temp_guess[a] = 5
      end
    end
    # We use the temp_guess and temp_code arrays because we've taken out the exact matches in the previous step; otherwise, we would double-count valid and near matches
    temp_guess.each do |i|
      if temp_code.include?(i)
        correct_value_only += 1
        temp_code.delete_at(temp_code.index(i))
      end
    end
    return correct_place_and_value if command == "Exact"
    return correct_value_only if command == "Near"
  end
end

