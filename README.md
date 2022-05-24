# Mastermind
This is a rendition of Mastermind created in Ruby. The goal of Mastermind is to break a code in a set number of tries. Players must guess a 4 digit code comprised of the numbers 1, 2, 3, and 4. Examples of valid codes/guesses: 1111, 1234, 4323, and 4433. After the player gives a guess, they receive feedback (not given in order); an 'X' for each correct number they guessed that was in the correct position, an 'O' for each correct number they guessed that was in the wrong position, and a '-' for each incorrect number. For example, if the code is 1234 and the player guesses 4134, they will receive the feedback 'XXO-'.

I implemented two game modes - Creator mode and Breaker mode.

## Creator mode:
In creator mode, the player gives the computer AI a code to break. Unfortunately, the AI always wins! Not by cheating, but through an implementation of Donald Knuth's algorithm, as described below:

> In 1977, Donald Knuth demonstrated that the codebreaker can solve the pattern in five moves or fewer, using an algorithm that progressively reduced the number of possible patterns. The algorithm works as follows:
> 1. Create the set S of 1296 possible codes (1111, 1112 ... 6665, 6666).
> 2. Start with initial guess 1122 (Knuth gives examples showing that other first guesses such as 1123, 1234 do not win in five tries on every code).
> 3. Play the guess to get a response of colored and white pegs.
> 4. If the response is four colored pegs, the game is won, the algorithm terminates.
> 5. Otherwise, remove from S any code that would not give the same response if the current guess were the code.

In essence, we pretend that our our first guess was the code and generate some theoretical feedback for every element in the set S. If the theoretical feedback does not match the actual feedback we got for the first guess, we remove that element from the set. Select a random remaining element from S for the second guess. Repeat in the next round but by pretending the second guess is the code. Eventually - in five moves or fewer - the array S of possible codes will wittle down to one element, and the codebreaker will win.

### Creator Demo
![image](https://user-images.githubusercontent.com/88121502/165209034-67f5342a-2483-4776-99e7-d3d5c8493493.png)

## Breaker mode:
In breaker mode, the computer will randomly select a valid four digit code comprised of 1, 2, 3, or 4. The player guesses and receives feedback. Much of the functionality required for this mode was already built to enable creator mode - but this mode is a little more fun to play.


### Breaker Demo
![image](https://user-images.githubusercontent.com/88121502/165209258-3f342a5d-278b-4354-87e1-29dfd8113087.png)
![image](https://user-images.githubusercontent.com/88121502/165209412-f7e8fd2b-cd88-4151-a19d-8cf0282df5e6.png)
