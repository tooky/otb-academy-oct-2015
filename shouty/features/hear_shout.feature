Feature: Hear Shout

  In order to find out whats going on locally
  As a shouty subscriber
  I want to hear shouts in my area

  Business Rules:
    - All subscribers hear all messages (for the moment)

  Todo:
    - Limit messages to listeners within range

  Scenario: Listener is within range
    Given Lucy is 15m from Sean
    When Sean shouts "Free Bagels!"
    Then Lucy hears Sean's message

  Scenario: Listener hears a different message
    Given Lucy is 15m from Sean
    When Sean shouts "Free Coffee!"
    Then Lucy hears Sean's message

  Scenario: Listener not in range
    Given Lucy is 500m from Sean
    When Sean shouts "Free Bagels!"
    Then Lucy does not hear Sean's message
