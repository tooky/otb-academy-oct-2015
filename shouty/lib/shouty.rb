class Person
  def initialize(network)
    @network = network
    @network.subscribe(self)
    @messages_heard = []
  end

  def move_to(location)
  end

  def shout(message)
    @network.broadcast(message)
    self
  end

  def hear(message)
    @messages_heard << message
  end

  def messages_heard
    @messages_heard
  end
end

class Network
  def initialize
    @subscribers = []
  end

  def subscribe(subscriber)
    @subscribers << subscriber
    self
  end

  def broadcast(message)
    @subscribers.each { |subscriber| subscriber.hear(message) }
  end
end
