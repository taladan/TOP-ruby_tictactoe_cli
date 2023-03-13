require "matrix"

class Board
  attr_reader :winner
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @winner = ""
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

  def play_piece(player, choice)
    cell = get_cell(choice)
    p cell
    if player == "Player 1"
      piece = "X"
    else
      piece = "O"
    end

    if self.playable?(cell)
      puts "playing #{piece} in #{choice}"
      @board_matrix[cell[0], cell[1]] = piece
    else
      puts "That cell has already been chosen"
    end
  end

  private

  # convert player choice to a matrix call (2 element array)
  def get_cell(choice)
    case choice
    when "a0"
      [0, 0]
    when "a1"
      [0, 1]
    when "a2"
      [0, 2]
    when "b0"
      [1, 0]
    when "b1"
      [1, 1]
    when "b2"
      [1, 2]
    when "c0"
      [2, 0]
    when "c1"
      [2, 1]
    when "c2"
      [2, 2]
    end
  end

  # Cell isn't playable if an X or O is already in it
  def playable?(cell)
    @board_matrix[cell[0], cell[1]] == " "
  end

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

  # We have to update the game grid each time a play is made
  def update_grid
    @row0 =
      "A\t#{@board_matrix[0, 0]}\t|\t#{@board_matrix[0, 1]}\t|\t#{@board_matrix[0, 2]}"
    @row1 =
      "B\t#{@board_matrix[1, 0]}\t|\t#{@board_matrix[1, 1]}\t|\t#{@board_matrix[1, 2]}"
    @row2 =
      "C\t#{@board_matrix[2, 0]}\t|\t#{@board_matrix[2, 1]}\t|\t#{@board_matrix[2, 2]}"
  end

  def game_grid
    update_grid
    # do not change any spacing within this declaration
    <<~BOARD
    #{@row_top}
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
end
