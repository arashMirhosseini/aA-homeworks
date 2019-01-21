module SlidingPiece
  
  def move
    # array of places that a piece can move to
    moves = []
    move_dirs.each do |x ,y|
      moves.concat(grow_unblocked_moves_in_dir(x, y))
    end
    moves
  end

  def move_dirs
    # subclass implements this
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    curr_x, curr_y = position 
    moves = []

    loop do
      curr_x, curr_y = curr_x + dx, curr_y + dy
      position = [curr_x, curr_y]
      break until board.vali_pos?(position)
      if board.empty?(position)
        moves << position
      else
        if color != board[position].color
          moves << position
          break
        end
      end
    end
    moves
  end

end