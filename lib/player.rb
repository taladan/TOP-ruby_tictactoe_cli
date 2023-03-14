# lib/player.rb

class Player
  attr_reader :name, :piece, :type
  attr_accessor :score
  def initialize(name, piece)
    @name = name
    @piece = piece
    @score = 0
    @type = "human"
  end

  protected

  attr_accessor :name, :piece, :type
end
