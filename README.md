# TOP-ruby_tictactoe_cli


## Assignment

Build a tic-tac-toe game on the command line where two human players can play against each other and the board is displayed in between turns.

1. Think about how you would set up the different elements within the game… What should be a class? Instance variable? Method? A few minutes of thought can save you from wasting an hour of coding.
2. Build your game, taking care to not share information between classes any more than you have to.
3. Post your solution on the odin project website, then check out [this example solution from RosettaCode.org](http://rosettacode.org/wiki/Tic-tac-toe#Ruby).


### Begin Pseudocode

TTT has the following components:
- A game board that is split into a 3 x 3 grid (object)
	- The grid consists of cells that hold a single character's data
- 2 players (either 2 human or 1 human/1 computer)
	- Players place pieces in turns until either a win state is reached or a tie state is reached
- A 'piece' indicator for players (traditionally 'X' and 'O')
- A win state:
	- Horizontal row of 3 - either X's or O's
	- Vertical row of 3 - either X's or O's
	- Diagonal row of 3 - either X's or O's
- If a win state is not reached and all spaces of the board are filled, we have reaced a Tie.
- A way to start a game
- A way to exit a game
- A way to track # of wins/losses/ties

#### How does a game of Tic Tac Toe run?
1. Pick players (2 human or 1 human & 1 computer)
2. Initialize the game board.
3. Draw the game board.
4. Start the game loop.
	1. Player 1 picks a cell to place an 'X' in.
	2. Redraw the game board with the most recent move
	3. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	4. Player 2 picks a cell to place an 'O' in.
	5. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	6.  Redraw the game board with the most recent move
	7. Player 1 picks a cell to place an 'X' in.
	8. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	9. Redraw the game board with the most recent move
	10. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	11. Player 2 picks a cell to place an 'O' in.
	12. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	13.  Redraw the game board with the most recent move
	14. Player 1 picks a cell to place an 'X' in.
	15. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	16. Redraw the game board with the most recent move
	17. Player 2 picks a cell to place an 'O' in.
	18. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	19.  Redraw the game board with the most recent move
	20. Player 1 picks a cell to place an 'X' in.
	21. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	22. Redraw the game board with the most recent move
	23. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	24. Player 2 picks a cell to place an 'O' in.
	25. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	26.  Redraw the game board with the most recent move
	27. Player 1 picks a cell to place an 'X' in.
	28. Check for win state, if win state, display winner and query to play again, if no win state, proceed
	29. After 9 moves, the board is full, if no win state has been reached, declare tie and query to play again.

#### What do we need?
With the preceeding description of a game of tic-tac-toe, we can see that there will need to be several different components to this game:

- A game board object that holds score data (wins/losses/ties) and board data.
- A cell object that holds data about whether it's been chosen or not.  If it has been chosen by a player, it needs to retain which player chose it and display their symbol (X or O)
- Player objects that contain the player's symbol (X or O)
- A game loop that runs no more than 9 moves.
- A way to redraw the game board to the screen with the appropriate data displayed regarding player choices
- A way to determine if win state has been reached
- A way to query the player(s) if they want to play again.
- A way to exit gracefully if no play is requested.