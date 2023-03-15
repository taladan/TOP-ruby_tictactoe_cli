# lib/computer.rb
require "./lib/player"
require "matrix"

class Computer < Player
  attr_reader :name, :piece

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
    available_slots = find_available(matrix.row_vectors)
    x_slots = find_xslots(matrix.row_vectors)
    o_slots = find_oslots(matrix.row_vectors)
  end

  # Block or play for advantage
  def pick_position(positions)
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
