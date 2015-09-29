# Tyre Pressure Alarm

You are working with a team building a racing car. You have been tasked with
building the code which alerts the team of problems with the tyre-pressure
system.

Included in the library is an interface to the Tyre Pressure Sensor. You will
find this code in `lib/sensor.rb`.

The sensor has a single method: `sample_pressure` which returns the current
tyre pressure in PSI.

```ruby
sensor = Sensor.new
sensor.sample_pressure # => 2.4364481286921538
```

You are required to develop, using TDD, an alarm class which checks the tyre
pressure using a sensor, and signals an alarm if the tyre pressure is outside
the normal range.

The tyres on this car should never be below 17.5 PSI or above 21 PSI.

The expected interface of the Alarm object is as follows:

```ruby
  alarm = Alarm.new( sensor ) # it will take a sensor as a constructor argument

  alarm.check                 # the check method will sample the sensor and
                              # decide if the alarm needs triggering
                              # it does not need to return any value

  alarm.on?                   # if the tyre pressure is outside the normal range
                              # this should return true, otherwise it will
                              # return false
```
