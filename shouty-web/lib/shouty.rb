class Person
  attr_accessor :location, :name
  def initialize(shoutbox, name)
    @shoutbox = shoutbox
    @name = name
    @location = 0
  end
  def shout(message)
    @shoutbox.deliver(self, message)
  end
  def hear(message)
    @last_heard_message = message
  end
  def last_heard_message
    @last_heard_message
  end
end

class Shoutbox
  def initialize
    @people = {}
  end
  def [](name)
    @people[name] ||= Person.new(self, name)
  end
  def deliver(shouter, message)
    @people.values.each do |person|
      distance = person.location - shouter.location
      if(distance <= 1000 && person != shouter)
        person.hear(message)
      end
    end
  end
end
