# frozen_string_literal: true
# Placeholder comment
module Algorithm
  def setup
    @set = [1, 2, 3, 4].repeated_permutation(4).to_a
    @guess = ["1", "1", "2", "2"]
    generate_feedback(@guess, @code)
    @gold_file_guess = @guess.clone
    @gold_file_feedback = @feedback.clone
    @round += 1
    show_board
    puts "I'm gonna start with 1122. I swear I won't cheat!" 
    puts
  end

  def compare_guess_and_feedback
    keepers = []
    @set.each_with_index do |element, index|
      generate_feedback(element, @gold_file_guess)
      if @feedback == @gold_file_feedback
        keepers.push(element)
      end
    end

    @set = keepers
    @guess = @set.sample
    generate_feedback(@guess, @code)
    @gold_file_guess = @guess.clone
    @gold_file_feedback = @feedback.clone
  end
 
end
# Placeholder comment
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
    puts 'The CODEBREAKER must guess the code within 12 rounds or the CODEMAKER wins.'
  end
end

# Placeholder comment
class Mastermind
  attr_accessor :name, :mode, :round, :board, :code, :guess, :feedback, :set, :gold_file_guess, :gold_file_feedback, :bad_index

  include Rules

  def initialize(name)
    @name = name.downcase.capitalize
    @round = 0
    @board = ['']
    @code = 0
    @guess = 0
    @feedback = []
    @output_statement = ''
  end

  def record_guess_and_feedback
    @board.concat [" #{@guess[0]}#{@guess[1]}#{@guess[2]}#{@guess[3]}#{@guess[4]} | | #{@feedback[0]}#{@feedback[1]}#{@feedback[2]}#{@feedback[3]}\n"]
  end

  def show_board
    puts
    puts "     Round #{@round}"
    puts @board.join(' ')
    puts
  end
end

class Creator < Mastermind
  include Algorithm

  def play
    rules
    human_generate_code
    setup()
    record_guess_and_feedback
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

  def generate_feedback(guess, code)
    @feedback = []
    calculate_matches("Exact", guess, code).times do
      @feedback.push('X')
    end
    calculate_matches("Near", guess, code).times do
      @feedback.push('O')
    end 
    [(4 - calculate_matches("Exact", guess, code) - calculate_matches("Near", code, guess)), 0].max.times do
      @feedback.push('-')
    end
  end

  def calculate_matches(command, guess_candidate, code_candidate)
    correct_place_and_value = 0
    correct_value_only = 0
    temp_code = code_candidate.clone.join().chars
    temp_code_two = code_candidate.clone.join().chars
    temp_guess = guess_candidate.clone.join().chars
    temp_guess_two = guess_candidate.clone.join().chars
    temp_guess_two.each_with_index do |i, a|
      if temp_guess_two[a] == temp_code_two[a]
        correct_place_and_value += 1
        temp_code[a] = 0
        temp_guess[a] = 5
      end
    end
    temp_guess.each do |i|
      if temp_code.include?(i)
        correct_value_only += 1
        temp_code.delete_at(temp_code.index(i))
      end
    end
    return correct_place_and_value if command == "Exact"
    return correct_value_only if command == "Near"
  end


  def human_generate_code
    puts "#{@name}, you're the CODEMAKER. Create a four-digit code for the computer to break."
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

#ee
class Breaker < Mastermind
  def generate_feedback()
    @feedback = []
    puts @feedback
    calculate_matches("Exact").times do
      @feedback.push('X')
    end
    calculate_matches("Near").times do
      @feedback.push('O')
    end 
    [(4 - calculate_matches("Exact") - calculate_matches("Near")), 0].max.times do
      @feedback.push('-')
    end
  end

  def calculate_matches(command)
    correct_place_and_value = 0
    correct_value_only = 0
    temp_code = @code.clone
    temp_guess = @guess.clone
    @guess.each_with_index do |i, a|
      if @code[a] == @guess[a]
        correct_place_and_value += 1
        temp_code[a] = 0
        temp_guess[a] = 5
      end
    end
    temp_guess.each do |i|
      if temp_code.include?(i)
        correct_value_only += 1
        temp_code.delete_at(temp_code.index(i))
      end
    end
    return correct_place_and_value if command == "Exact"
    return correct_value_only if command == "Near"
  end

  def play
    rules
    computer_generate_code
    while game_on?
      human_guess
      generate_feedback
      record_guess_and_feedback
      show_board
    end
    puts @output_statement
  end

  def computer_generate_code
    @code = Array.new(4) { rand(1..4).to_s }
  end

  def human_guess
    @round += 1
    if @round < 2
      puts "#{@name}, you're the CODEBREAKER. After your guess, we'll display how many digits are correct place and value (X), how many are only correct value (O), and how many are neither (-). What is your guess?"
    end
    @guess = $stdin.gets.chomp.to_s.chars
    until @guess.all? { |i| VALID.include?(i) } && @guess.length == 4
      puts 'Please input a 4 digit code using only the numbers 1, 2, 3, and 4.'
      @guess = $stdin.gets.chomp.to_s.chars
    end
  end
end

CreatorGame = Creator.new('Alice')
#CreatorGame.play
BreakerGame = Breaker.new('Bob')
BreakerGame.play