# lib/player.rb

class Player
  attr_reader :name, :piece
  attr_accessor :score
  def initialize(name, piece)
    @name = name
    @piece = piece
    @score = 0
  end
end
