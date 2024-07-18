Feature: User bulletin board
    As a registered user with an existing account,
    I want view my QR code 
    So that I can allow ngo to scan it

Background:
    Given a user logged in with email "user1@mail.com" and password "password1"

Scenario: Viewing bulletin board
    Given i am on the digital id page
    When i click on “bulletin board” button,
    I should be redirected to the “bulletin board” page,
    And i should see post made by ngos
    And the top post should be the most recent post

Scenario: Saving post
    When i click on save this post,
    I should see a notification that the post have been saved
    When i click saved post button,
    I should be redirected to “save post” page
    And I should see the post i had previously pressed saved on
