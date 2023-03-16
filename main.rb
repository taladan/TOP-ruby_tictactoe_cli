# tictactoe.rb
require "matrix"
require "./lib/board"
require "./lib/player"
require "./lib/messaging"
include Messaging

system("clear") || system("cls")

def start_game()
  answer = play?()
  if answer
    write("\nPlease enter the name of player 1:> ")
    reply = gets.chomp
    player1 = Player.new(reply, "X")
    write("\nThank you! Setting #{player1.name} as Player 1")
    write("\nPlease enter the name of player 2:> ")
    reply = gets.chomp
    player2 = Player.new(reply, "O")
    write("\nThank you!  Setting #{player2.name} as Player 2\n")
    write("\nSetting up game board\n")
    # new_game = Board.new(player1, player2)
    write("Reticulating Splines")
    write("....", rand(0..1))
    # Game loop should go here
    play_again = true
    until play_again == false
      new_game = Board.new(player1, player2)
      game_loop(new_game, player1, player2)
      play_again = play_again?()
    end

    exit_sequence() if play_again == false
  else
    exit_sequence()
  end
end

def exit_sequence()
  system("clear") || system("cls")
  write(
    "You don't want to play?  Perhaps you would rather a game of Global Thermo-Nuclear Warfare instead?",
  )
  write("\nExiting\n")
  write("\n3", 1)
  write("\n2", 1)
  write("\n1", 1)
  write("\n\n\t\t\tGoodbye\n", 0.5)
  exit(true)
end

def play?()
  write("Hello, would you like to play a game of Tic-Tac-Toe? (Y/N)")
  answer = ""
  until %w[y n].include? answer
    puts "\n"
    write("Please choose Y or N.:> ")
    answer = gets.chomp.downcase
  end
  answer == "y"
end

def play_again?()
  answer = ""
  until %w[y n].include? answer
    write("Would you like to play again?")
    puts "\n"
    answer = gets.downcase.chomp
  end
  answer == "y"
end

# This is unused right now.  Next iteration of TTT
def number_of_players()
  until [1, 2].include? total_players
    puts "\n"
    write("How many players will there be? (2 maximum):> ")
    total_players = gets.chomp.to_i
  end
  total_players
end

def game_loop(game, player1, player2)
  turn = player1
  until game.game_over
    game.game_over()
    game.draw_board()
    write("It's #{turn.name}'s turn. ")
    game.play_piece(turn)
    if turn == player1
      turn = player2
    else
      turn = player1
    end
  end
  if game.game_over && game.winner == "Tie"
    write("The game ends in a draw!\n")
    game.ties += 1
  elsif game.game_over
    write("The winner of this round is: #{game.winner.name}\n")
    game.winner.score += 1
  end
end

start_game()
