# frozen_string_literal: true

require_relative 'mastermind'

class Creator < Mastermind
  
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
