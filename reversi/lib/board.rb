require_relative 'point'

class Board
  attr_reader :turn

  def initialize(input)
    parse(input)
  end

  def set_char(char, position)
    @board[position.y][position.x] = char
  end

  def char_at(position)
    return nil if [position.x, position.y].max >= size
    return @board[position.y][position.x]
  end

  def all(char)
    result = []
    @board.each_index do |index_y|
      @board[index_y].each_index do |index_x|
        value = @board[index_y][index_x]
        result << Point.new(index_x, index_y) if value == char
      end
    end
    result
  end

  def to_s
    @board.map { |e| e.join('')  }.join("\n") + "\n#{@turn}"
  end

  private
  def parse(input)
    @turn = input[-1, 1]
    @board = multi_array_from(input.chop.chomp, "\n")
  end

  def size
    @board.count
  end

  def multi_array_from(string, end_line)
    string.split(end_line).map { |s| s.split(//) }
  end

end
