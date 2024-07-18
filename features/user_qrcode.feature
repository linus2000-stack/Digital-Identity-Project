Feature: user digitalID QR code
    As a registered user with an existing account,
    I want view my QR code 
    So that I can allow ngo to scan it

Background:
    Given a user logged in with email "user1@mail.com" and password "password1"

Scenario: Viewing the QR code
    Given i am on the “Digital ID” page,
    When i click on the "QR logo" button, 
    Then the digitalID card will flip,
    And i should see a unique qrcode,
