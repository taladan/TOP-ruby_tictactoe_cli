# tictactoe.rb

require "./lib/board"

system("clear") || system("cls")
msg = "Hello, would you like to play a game of Tic-Tac-Toe? (Y/N)"
answer = ""

msg.each_char do |c|
  putc c
  sleep 0.10
end

until %w[y n].include? answer
  puts "\n"
  puts "Please choose Y or N."
  answer = gets.chomp.downcase
end

if answer == "y"
  my_game = Board.new("Human", "Computer")
  my_game.draw_board()
  my_game.game_over?
elsif answer == "n"
  exit(true)
end
