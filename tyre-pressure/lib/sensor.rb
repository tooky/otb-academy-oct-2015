class Sensor
  def sample_pressure
    # simulate a real sensor in a tyre
    16 + (6 * rand * rand)
  end
end
