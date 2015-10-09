require_relative 'board'

class Reversi

  def legal_moves(input_board)
    @board = Board.new(input_board)
    draw_moves(all_moves)
  end

  private
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
    direcions = []
    -1.upto(1) { |x|
      -1.upto(1) { |y|
        direcions << Point.new(x, y)
      }
    }
    direcions
  end

  def find_legals(position, direction, counter)
    next_position = position + direction
    char = @board.char_at(position)
    next_char = @board.char_at(next_position)
    if first_char?(counter) || (oposite?(char) && oposite?(next_char))
      find_legals(next_position, direction, counter + 1)
    elsif oposite?(char) && free?(next_char)
      next_position
    else
      nil
    end
  end

  def first_char?(counter)
    counter == 0
  end

  def oposite?(char)
    char == oposite_player(@board.turn)
  end

  def free?(char)
    char == '.'
  end

  def oposite_player(player)
    return nil if player != "W" && player != "B"
    player == "B" ? "W" : "B"
  end

end
