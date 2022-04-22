# This is an implementation of Donald Knuth's algorithm. 
# We make a set of all possible code permutations, then pretend our code was the solution.
# Compare each permutation against the imaginary feedback that would be generated if our previous guess was the solution. 
# If the new imaginary feedback does not match the previous guess' feedback, we remove that permutation from the set.
# Repeat with a random guess that is still in the set.
module Algorithm

  def setup_permutations
    # Create and array with all permutations of 4 digit code that uses 1, 2, 3, and 4 
    @set = [1, 2, 3, 4].repeated_permutation(4).to_a
    @guess = ["1", "1", "2", "2"]
  end

  def setup
    setup_permutations
    # Generate the first feedback; we'll pretend our first guess was the solution
    generate_feedback(@guess, @code)
    # The 'gold_file' refers to the guess and feedback that we pretend are the solution and which we compare to all remaining permutations in the set
    @gold_file_guess = @guess.clone
    @gold_file_feedback = @feedback.clone
    @round += 1
  end
  
  # Take a random permutation that survived our previous culling of permutations and make it the new guess
  def initialize_new_round
    @guess = @set.sample
    generate_feedback(@guess, @code)
    @gold_file_guess = @guess.clone
    @gold_file_feedback = @feedback.clone
  end

  # Compare an input guess with a previous guess' feedback and keep the matches
  def compare_guess_and_feedback
    keepers = []
    @set.each_with_index do |element, index|
      generate_feedback(element, @gold_file_guess)
      if @feedback == @gold_file_feedback
        keepers.push(element)
      end
    end
    @set = keepers
    initialize_new_round
  end 
end
