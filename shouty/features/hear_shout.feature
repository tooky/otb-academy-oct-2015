Feature: Hear Shout

  In order to find out whats going on locally
  As a shouty subscriber
  I want to hear shouts in my area

  Business Rules:
    - Range is 50m

  Scenario: Listener is within range
    Given Lucy is 15m from Sean
    When Sean shouts "Free Bagels!"
    Then Lucy hears Sean's message

  Scenario: Listener hears a different message
    Given Lucy is 15m from Sean
    When Sean shouts "Free Coffee!"
    Then Lucy hears Sean's message
