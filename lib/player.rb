# lib/player.rb

class Player
  attr_reader :name, :piece, :type
  attr_accessor :score, :name
  def initialize(name, piece)
    @name = name
    @piece = piece
    @score = 0
    @type = "human"
  end
end
