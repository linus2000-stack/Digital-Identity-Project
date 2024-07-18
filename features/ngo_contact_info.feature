Feature: NGO contact infomation
    As a registered user with an existing account,
    I want view my QR code 
    So that I can allow ngo to scan it
Background:
    Given a user logged in with email "user1@mail.com" and password "password1"

Scenario: Viewing NGO contact information 
    Given i am on the digital id page,
    When i click on “search for ngo” button, 
    I will be redirected to “search for ngo” page,
    I should see a list of ngo with their logo and accompanied contact details,
