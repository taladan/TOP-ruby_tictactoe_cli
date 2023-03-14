require "matrix"
require "./lib/cells"
require "./lib/messaging"
include Cells
include Messaging

class Board
  attr_accessor :game_over
  attr_reader :board_matrix
  def initialize(p1, p2)
    @player1 = p1
    @player2 = p2
    @winner = ""
    # This will be deprecated after full implementation of player objects
    @scores = { p1: 0, p2: 0, ties: 0 }
    @separator_line = "   _____________|_______________|______________   "
    @space_line = "                |               |                "
    # Currently using for testing win-state settings
    # @board_matrix = Matrix[%w[X O O], %w[X O X], %w[X X O]]
    # Uncomment before finish
    @board_matrix = Matrix[[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    @row_top = " \t0\t \t1\t \t2"
    @row0 =
      "A\t#{@board_matrix[0, 0]}\t|\t#{@board_matrix[0, 1]}\t|\t#{@board_matrix[0, 2]}"
    @row1 =
      "B\t#{@board_matrix[1, 0]}\t|\t#{@board_matrix[1, 1]}\t|\t#{@board_matrix[1, 2]}"
    @row2 =
      "C\t#{@board_matrix[2, 0]}\t|\t#{@board_matrix[2, 1]}\t|\t#{@board_matrix[2, 2]}"
    @game_over = false
  end

  def draw_board()
    system("clear") || system("cls")
    print game_grid()
  end

  def game_over
    check_win_state()
    @game_over
  end

  def computer_play(player)
    # TODO
  end

  def play_piece(player)
    choice = ""

    # Is the choice valid (in the range a0..c2)
    until input_valid?(choice)
      write("Please choose a spot to place your piece:> ")
      choice = gets.chomp
    end

    cell = get_cell(choice)
    piece = player.piece

    # is the choice playable?
    until playable?(@board_matrix, cell)
      write("That spot is already taken.  Please choose again")
      # Call to reset player choice
    end
    @board_matrix[cell[0], cell[1]] = piece
  end

  private

  def check_win_state()
    if blank?()
      @game_over = false
      @winner = ""
    elsif full?()
      @game_over = true
      @winner = "Tie"
      @scores[:ties] += 1
    end
    check_cols()
    check_rows()
    check_diagonals()
  end

  def check_diagonals()
    if (0..2).map { |cell| @board_matrix[cell, cell] }.all?("X") ||
         2.downto(0).map { |cell| @board_matrix[cell, cell] }.all?("X")
      @winner = "Player 1"
      @player1.score += 1
      @game_over = true
    elsif (0..2).map { |cell| @board_matrix[cell, cell] }.all?("O") ||
          2.downto(0).map { |cell| @board_matrix[cell, cell] }.all?("O")
      @winner = "Player 2"
      @player2.score += 1
      @game_over = true
    end
  end

  def check_rows()
    rows = (0..2).to_a
    rows.each do |row|
      if @board_matrix.row(row).all?("X")
        @winner = "Player 1"
        @player1.score += 1
        @game_over = true
      elsif @board_matrix.row(row).all?("O")
        @winner = "Player 2"
        @player2.score += 1
        @game_over = true
      end
    end
  end

  def check_cols()
    columns = (0..2).to_a
    columns.each do |col|
      if @board_matrix.column(col).all?("X")
        @winner = "Player 1"
        @player1.score += 1
        @game_over = true
      elsif @board_matrix.column(col).all?("O")
        @winner = "Player 2"
        @player2.score += 1
        @game_over = true
      end
    end
  end

  def blank?
    @board_matrix.all? { |elem| elem == " " }
  end

  def full?
    @board_matrix.none? { |elem| elem == " " }
  end

  # We have to update the game grid each time a play is made
  def update_grid
    @row0 =
      "A\t#{@board_matrix[0, 0]}\t|\t#{@board_matrix[0, 1]}\t|\t#{@board_matrix[0, 2]}"
    @row1 =
      "B\t#{@board_matrix[1, 0]}\t|\t#{@board_matrix[1, 1]}\t|\t#{@board_matrix[1, 2]}"
    @row2 =
      "C\t#{@board_matrix[2, 0]}\t|\t#{@board_matrix[2, 1]}\t|\t#{@board_matrix[2, 2]}"
  end

  def put_status()
    print "Winner of this round: #{@winner}" if @game_over
  end

  def game_grid
    update_grid()
    put_status()
    # do not change any spacing within this declaration
    <<~BOARD
    #{@row_top}
    #{@space_line}\tScores:
    #{@row0}
    #{@separator_line}\t\t#{@player1.name}: #{@player1.score}
    #{@space_line}\t\t#{@player2.name}: #{@player2.score}
    #{@row1}\t\t\tTies:     #{@scores[:ties]}
    #{@separator_line}
    #{@space_line}
    #{@row2}
    #{@space_line}
    BOARD
  end
end
