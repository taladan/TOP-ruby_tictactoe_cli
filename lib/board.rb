require './lib/cells'
require './lib/messaging'

# Tic Tac Toe Board
class Board
  include Cells
  include Messaging
  attr_accessor :ties
  attr_reader :board_matrix, :winner

  def initialize(p1, p2, matrix = Matrix[[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']])
    @player1 = p1
    @player2 = p2
    @winner = ''
    @separator_line = '   _____________|_______________|______________   '
    @space_line = '                |               |                '
    @board_matrix = matrix
    @row_top = " \t0\t \t1\t \t2"
    @row0 =
      "A\t#{@board_matrix[0, 0]}\t|\t#{@board_matrix[0, 1]}\t|\t#{@board_matrix[0, 2]}"
    @row1 =
      "B\t#{@board_matrix[1, 0]}\t|\t#{@board_matrix[1, 1]}\t|\t#{@board_matrix[1, 2]}"
    @row2 =
      "C\t#{@board_matrix[2, 0]}\t|\t#{@board_matrix[2, 1]}\t|\t#{@board_matrix[2, 2]}"
    @game_over = false
    @ties = 0
  end

  def draw_board
    system('clear') || system('cls')
    print game_grid
  end

  def game_over?
    check_win_state
    @game_over
  end

  def play_piece(player)
    # if spot is playable? Play spot.  Otherwise prompt for a new spot and try to play again.
    cell = get_cell(get_player_choice)
    piece = player.piece
    until playable?(@board_matrix, cell)
      write('That spot is already taken.\n')
      cell = get_cell(get_player_choice)
    end
    @board_matrix[cell[0], cell[1]] = piece
  end

  private

  def get_player_choice
    choice = ''
    until input_valid?(choice)
      write('Please choose a spot to place your piece:> ')
      choice = gets.chomp
    end
    choice
  end

  def check_win_state
    if blank?
      @game_over = false
      @winner = ''
    elsif full?
      @game_over = true
      @winner = 'Tie'
    end
    check_cols
    check_rows
    check_diagonals
  end

  def check_diagonals
    # Check from top left to bottom right
    top_left_to_bottom_right = (0..2).map { |cell| @board_matrix[cell, cell] }
    # If we rotate the matrix then check from top left to bottom right, this is the same as checking from
    # bottom left to top right
    bottom_left_to_top_right = (0..2).map { |cell| @board_matrix.rotate_entries[cell, cell] }

    @winner = @player1 && @game_over = true if top_left_to_bottom_right.all?('X') || bottom_left_to_top_right.all?('X')
    @winner = @player2 && @game_over = true if top_left_to_bottom_right.all?('O') || bottom_left_to_top_right.all?('O')
  end

  def check_rows
    rows = (0..2).to_a
    rows.each do |row|
      if @board_matrix.row(row).all?('X')
        @winner = @player1
        @game_over = true
      elsif @board_matrix.row(row).all?('O')
        @winner = @player2
        @game_over = true
      end
    end
  end

  def check_cols
    columns = (0..2).to_a
    columns.each do |col|
      if @board_matrix.column(col).all?('X')
        @winner = @player1
        @game_over = true
      elsif @board_matrix.column(col).all?('O')
        @winner = @player2
        @game_over = true
      end
    end
  end

  def blank?
    @board_matrix.all? { |elem| elem == ' ' }
  end

  def full?
    @board_matrix.none? { |elem| elem == ' ' }
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

  def put_status
    print "Winner of this round: #{@winner}" if game_over?
  end

  def game_grid
    update_grid
    put_status
    # do not change any spacing within this declaration
    <<~BOARD
      #{@row_top}
      #{@space_line}\tScores:
      #{@row0}
      #{@separator_line}\t\t#{@player1.name}: #{@player1.score}
      #{@space_line}\t\t#{@player2.name}: #{@player2.score}
      #{@row1}
      #{@separator_line}
      #{@space_line}
      #{@row2}
      #{@space_line}
    BOARD
  end
end
