class Board
  attr_reader :scores

  @scores = { p1: 0, p2: 0 }
  @separator_line = "________________|_______________|_________________"
  @space_line = "                |               |                "
  @a0 = "\tX\t|"
  @a1 = "\tO\t|"
  @a2 = "\tX"
  @b0 = "\tO\t|"
  @b1 = "\tX\t|"
  @b2 = "\tO"
  @c0 = "\tX\t|"
  @c1 = "\tO\t|"
  @c2 = "\tX"

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def self.clear_screen
    system("clear") || system("cls")
  end

  def self.draw_board
    # figure out how to draw the board
    clear_screen()
    print self.game_grid()
  end

  def self.game_grid
    <<~BOARD
    #{@space_line}
     #{@a0}#{@a1}#{@a2}
    #{@separator_line}
    #{@space_line}
     #{@b0}#{@b1}#{@b2}
    #{@separator_line}
    #{@space_line}
     #{@c0}#{@c1}#{@c2}
    #{@space_line}
    BOARD
  end

  draw_board()
end
