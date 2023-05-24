# lib/computer.rb
require "./lib/player"
require "./lib/matrix"

class Computer < Player
  attr_reader :name, :piece, :type

  def initialize(name, piece)
    super(name, piece)
    @type = "computer"
  end

  def play_piece(matrix)
    positions = analyze_matrix(matrix)
    choice = pick_position(positions)
    play_position(choice)
  end

  # find filled and empty spots
  def analyze_matrix(matrix)
    pos = {
      available_slots: find_available(matrix.row_vectors),
      x_slots: find_xslots(matrix.row_vectors),
      o_slots: find_oslots(matrix.row_vectors),
    }
    pos
  end

  # Block or play for advantage
  def pick_position(hash)
    if @piece = "X"
      my_slots = hash[:x_slots]
      their_slots = hash[:o_slots]
    else
      my_slots = hash[:o_slots]
      their_slots = hash[:x_slots]
    end

    # check my piece and look for vectors that will allow
    # for a win.

    # For any vector or diagonal that has (2 of 'my' pieces
    # OR 2 of 'their' pieces) AND an empty cell, I need to
    # play my piece in the empty cell for either a win or
    # block.
    # if there is one cell available in a vector or diagonal and the filled cells are both "X" or "O", play there.

    # This gets the first elements from each array in the value passed, tallies them and selects the values that are equal to 2
    two_x_vector =
      hsh[:x_slots].map(&:first).tally.select { |key, value| value == 2 }.keys
    two_o_vector =
      hsh[:o_slots].map(&:first).tally.select { |key, value| value == 2 }.keys

    # If there are not 2 of 'my' or 'their' pieces on a
    # diagonal or vector, if there is an empty cell on
    # a diag or vector that I have a piece next to (set up win
    # chance for My next play), then put my piece there.

    # If there are no spaces where a win condition will be
    # possible, play to tie and always prefer a corner.

    # If I go first, always pick a random corner or outside
    # middle cell (never pick the center cell first).
  end

  #put piece on board
  def play_position(choice)
  end

  def find_available(vects)
    avail = []
    vects.each_with_index do |vector, vector_index|
      vector.each_with_index do |element, element_index|
        avail.push([vector_index, element_index]) if element == " "
      end
    end
    avail
  end

  def find_xslots(vects)
    xs = []
    vects.each_with_index do |vector, vector_index|
      vector.each_with_index do |element, element_index|
        xs.push([vector_index, element_index]) if element == "X"
      end
    end
    xs
  end

  def find_oslots(vects)
    os = []
    vects.each_with_index do |vector, vector_index|
      vector.each_with_index do |element, element_index|
        os.push([vector_index, element_index]) if element == "O"
      end
    end
    os
  end
end

def find_diagonal(matrix)
  diagonal = matrix.extract_diagonal.to_a
  diagonal
end

def find_antidiagonal(matrix)
  antidiagonal = matrix.rotate.extract_diagonal.to_a
  antidiagonal
end
