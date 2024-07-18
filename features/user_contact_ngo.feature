Feature: Contacting NGO
    As a registered user with an existing account,
    I want view my QR code 
    So that I can allow ngo to scan it
Background:
    Given a user logged in with email "user1@mail.com" and password "password1"

Scenario: Chatting with an NGO
    Given i am on the “search for ngo” page,
    When i click the “chat with ngo” button,
    I should see a chat box open 
    And i should see prompt questions to ask the ngo (not needed)

Scenario: sending NGO a message
    When i send a message, 
    Then the ngo should receive and view my message

Scenario: Receiving NGO’s message
    When ngo send a message, 
    Then i should receive and view the message

Scenario: Notification??
