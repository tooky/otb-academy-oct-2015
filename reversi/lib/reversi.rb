require_relative 'board'

class Reversi

  def legal_moves(input_board)
    @board = Board.new(input_board)
    draw_moves(all_moves)
  end

  def draw_moves(positions)
    positions.each { |position| @board.set_char('0', position) }
    @board.to_s
  end

  def all_moves
    @board.all(@board.turn).inject([]) { |memo, position|
      memo += find_all_directions(position)
    }.compact
  end

  def find_all_directions(position)
    all_directions.map { |direction| find_legals(position, direction, 0) }
  end

  def all_directions
    [Point.new(-1, -1), Point.new(-1, 0), Point.new(-1, 1),
    Point.new(0, -1), Point.new(0, 0), Point.new(0, 1),
    Point.new(1, -1), Point.new(1, 0), Point.new(1, 1)
    ]
  end

  def find_legals(position, direction, counter)
    next_position = position + direction
    object = @board.char_at(position)
    next_object = @board.char_at(next_position)
    return nil unless object && next_object
    if counter == 0
      return find_legals(next_position, direction, counter + 1)
    elsif object != oposite_player(@board.turn)
      return nil
    else object == oposite_player(@board.turn)
      if next_object == '.'
        return next_position
      else
        return find_legals(next_position, direction, counter + 1)
      end
    end
    nil
  end

  def oposite_player(player)
    return nil if player != "W" && player != "B"
    player == "B" ? "W" : "B"
  end

end
