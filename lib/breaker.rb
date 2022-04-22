
require_relative 'Mastermind'

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