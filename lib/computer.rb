# lib/computer.rb
require "./lib/player"
require "matrix"

class Computer < Player
  attr_reader :name, :piece

  def initialize(name, piece, matrix)
    super(name, piece)
    @matrix = matrix
    @type = "computer"
  end
end
