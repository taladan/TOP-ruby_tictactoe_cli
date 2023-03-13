# lib/player.rb

class Player
  attr_reader :name
  def initialize(name, piece)
    @name = name
    @piece = piece
    @score = 0
  end

  protected

  attr_accessor :score
end
