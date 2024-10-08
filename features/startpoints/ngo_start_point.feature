Feature: Verify user particulars and account
  As a non-governmental organization(NGO) personnel approached to help provide verification for an undocumented user's EnableID account on the 4th July 2024,
  I want to view information from his/her EnableID account to help determine the authenticity of his/her identity
  So that I can mark the personal particualrs of his/her EnableID account as verified.

Background:
  Given a user particular exists with unique ID "1055290" and 2FA code "606833"

Scenario: Going to my own "NGO" page
  Given I am on the "Login" page
  When I press the "I am a NGO" button
  Then I should see a set of different NGO buttons 
  When I press the NGO "Gebirah" card
  Then I should be redirected to the NGO "Gebirah" page

Scenario: Retrieving undocumented user's EnableID personal particulars, then verify the person
  Given I am already on my NGO "Gebirah" page
  And I press the "Verify User" button
  When I key in the Unique ID: '1055290" and 6 digit code 2FA: "606833", then I press the check button
  Then I should be redirected to the User Verification page under "Gebirah"
  And I should see his/her EnableID card
  And I should see "1055290"

  When I click all the boxes in the verification checklist
  And I press the "Verify" button 
  Then I should be redirected to the NGO "Gebirah" page

Scenario: Wrong Unique ID number
  Given I am already on my NGO "Gebirah" page
  And I press the "Verify User" button
  When I key in the Unique ID: '11111111" and 6 digit code 2FA: "99999999", then I press the check button
  Then I should see "User not found. Please check your Unique ID and 2FA Code."
