Feature: View upload documents
    As a registered user with an existing account,
    I want view my QR code 
    So that I can allow ngo to scan it
Background:   
    Given a user logged in with email "user1@mail.com" and password "password1"

Scenario: going to uploaded documents page
    Given i am on the "digital id" page,
    When i click on the documents button
    I should be redirected to documents page
    And i should see a list of documents the user have upload, 
    When i click upload documents,
    I should be redirected to upload document page
