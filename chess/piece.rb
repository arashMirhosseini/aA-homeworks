# require_relative "sildingPiece"

class Piece
  attr_accessor :color, :position
  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def move
  end


end