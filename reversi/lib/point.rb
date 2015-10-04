class Point
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def +(point)
    Point.new(@x + point.x, @y + point.y)
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end
