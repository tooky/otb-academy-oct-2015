require 'blink1'

class BlinkNotifier
  def initialize
    Blink1.open do |blink1|
      blink1.write_pattern_line(100, 255, 255, 255, 0)
      blink1.write_pattern_line(100, 255,   0,   0, 1)
      blink1.write_pattern_line(100, 255, 255, 255, 2)
      blink1.write_pattern_line(100, 255,   0,   0, 3)
      (4..32).each { |n| blink1.write_pattern_line(0,0,0,0,n) }
    end
  end

  def out_of_bounds
    Blink1.open do |blink1|
      blink1.play(0)
    end
  end

  def normal_range
    Blink1.open do |blink1|
      blink1.off
    end
  end
end
