Feature: Locating family members
    As a registered user with an existing account,
    I want view my QR code 
    So that I can allow ngo to scan it

Background:
    Given a user logged in with email "user1@mail.com" and password "password1"

Scenario: Adding family member
    Given i am on the digital id page
    When i click add a family member,
    I should be redirected to add a family page
    I should see field to enter information about my family member
    The relationship
    Documents to proof relationship if any
    Images of the person in any
