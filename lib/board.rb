require "matrix"

class Board
  attr_reader :winner
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @winner = ""
    @scores = { p1: 0, p2: 0, ties: 0 }
    @separator_line = "________________|_______________|_________________"
    @space_line = "                |               |                "
    @board_matrix = Matrix[%w[X O O], %w[X O X], %w[X X O]]
    #@board_matrix = Matrix[[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]
    @row0 =
      "\t#{@board_matrix[0, 0]}\t|\t#{@board_matrix[0, 1]}\t|\t#{@board_matrix[0, 2]}"
    @row1 =
      "\t#{@board_matrix[1, 0]}\t|\t#{@board_matrix[1, 1]}\t|\t#{@board_matrix[1, 2]}"
    @row2 =
      "\t#{@board_matrix[2, 0]}\t|\t#{@board_matrix[2, 1]}\t|\t#{@board_matrix[2, 2]}"
    @game_over = false
  end

  def draw_board()
    # figure out how to draw the board
    system("clear") || system("cls")
    print game_grid()
  end

  def game_over?
    check_win_state()
    @game_over
  end

  private

  def check_win_state()
    if blank?()
      @game_over = false
      @winner = ""
    end
    check_cols()
    check_rows()
    check_diagonals()
  end

  def check_diagonals()
    if (0..2).map { |cell| @board_matrix[cell, cell] }.all?("X") ||
         2.downto(0).map { |cell| @board_matrix[cell, cell] }.all?("X")
      @winner = "Player 1"
      @scores[:p1] += 1
      @game_over = true
    elsif (0..2).map { |cell| @board_matrix[cell, cell] }.all?("O") ||
          2.downto(0).map { |cell| @board_matrix[cell, cell] }.all?("O")
      @winner = "Player 2"
      @scores[:p2] += 1
      @game_over = true
    end
  end

  def check_rows()
    rows = (0..2).to_a
    rows.each do |row|
      if @board_matrix.row(row).all?("X")
        @winner = "Player 1"
        @scores[:p1] += 1
        @game_over = true
      elsif @board_matrix.row(row).all?("O")
        @winner = "Player 2"
        @scores[:p2] += 1
        @game_over = true
      end
    end
  end

  def check_cols()
    columns = (0..2).to_a
    columns.each do |col|
      if @board_matrix.column(col).all?("X")
        @winner = "Player 1"
        @scores[:p1] += 1
        @game_over = true
      elsif @board_matrix.column(col).all?("O")
        @winner = "Player 2"
        @scores[:p2] += 1
        @game_over = true
      end
    end
  end

  def blank?
    @board_matrix.all? { |elem| elem == " " }
  end

  def game_grid
    # do not change any spacing within this declaration
    <<~BOARD
    #{@space_line}\tScores:
    #{@row0}
    #{@separator_line}\t\tPlayer 1: #{@scores[:p1]}
    #{@space_line}\t\tPlayer 2: #{@scores[:p2]}
    #{@row1}\t\t\tTies:     #{@scores[:ties]}
    #{@separator_line}
    #{@space_line}
    #{@row2}
    #{@space_line}
    BOARD
  end

  def all_equal?(arr)
    # To fix
    arr.uniq.size == 1
  end
end
