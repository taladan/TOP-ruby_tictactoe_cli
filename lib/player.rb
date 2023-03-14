# lib/player.rb

class Player
  attr_reader :name
  attr_accessor :score
  def initialize(name, piece)
    @name = name
    @piece = piece
    @score = 0
  end
end
