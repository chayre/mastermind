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
    @board.concat [" #{@guess[0]}#{@guess[1]}#{@guess[2]}#{@guess[3]}#{@guess[4]} | | #{@feedback[0]}#{@feedback[1]}#{@feedback[2]}#{@feedback[3]}\n"]
  end

  def show_board
    puts
    puts "     Round #{@round}"
    puts @board.join(' ')
    puts
  end
end

