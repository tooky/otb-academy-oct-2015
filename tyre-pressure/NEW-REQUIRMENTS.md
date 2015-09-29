# Different Notifications

The management have decided that they want to be able to use different
indicators on different cars. As such they want to change the interface of the
alarm class.

An `Alarm` will now be initialized with a sensor and a notifier.

```ruby
sensor = Sensor.new
notifier = ... # NOTE: no notifiers has yet been developed.

alarm = Alarm.new(sensor, notifier)

alarm.check # this will check the tyre pressure using the sensor
            # if the tyre pressure is out of bounds then the alarm will
            # tell the notifier that it is out of range
            #
            # notifier.out_of_bounds
            #
            # if the tyre pressure is within the normal range it will tell the
            # notifier
            #
            # notifier.normal_range
```

The `#on?` interface of the alarm is no longer required - notifiers will be
responsible for maintaining their signal.
