# tictactoe.rb
require "./lib/board"
require "./lib/player"
require "./lib/messaging"
include Messaging

system("clear") || system("cls")

def start_game()
  answer = play?()
  if answer
    total_players = ""
    until [1, 2].include? total_players
      puts "\n"
      write("How many players will there be? (2 maximum):> ")
      total_players = gets.chomp.to_i
    end

    if total_players == 2
      write("\nPlease enter the name of player 1:> ")
      reply = gets.chomp
      player1 = Player.new(reply, "X")
      write("\nThank you! Setting #{player1.name} as Player 1")
      write("\nPlease enter the name of player 2:> ")
      reply = gets.chomp
      player2 = Player.new(reply, "O")
      write("\nThank you!  Setting #{player2.name} as Player 2\n")
    elsif total_players == 1
      write("Pitting your wits against the Computer!  Excellent!\n")
      write("Enter your name:> ")
      reply = gets.chomp
      player1 = Player.new(reply, "X")
      write("\nThank you! Setting #{player1.name} as Player 1\n")
      player2 = Player.new("Computer", "O")
      write("I will assume the role of Player 2.  This is going to be so fun!")
    end

    write("\nSetting up game board\n")
    new_game = Board.new(player1, player2)
    write("Reticulating Splines")
    write("....", rand(0..1))
    # Game loop should go here
    game_loop(new_game, player1, player2)
  else
    write(
      "You don't want to play?  Perhaps you would rather a game of Thermo-Nuclear Warfare instead?",
    )
    write("\nExiting\n")
    write("\n3", 1)
    write("\n2", 1)
    write("\n1", 1)
    write("\n\n\t\t\tGoodbye\n", 0.5)
    exit(true)
  end
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

def game_loop(game, player1, player2)
  turn = player1
  until game.game_over
    game.game_over()
    game.draw_board()
    game.play_piece(turn)
    if turn == player1
      turn = player2
    else
      turn = player1
    end
  end
end

start_game()
