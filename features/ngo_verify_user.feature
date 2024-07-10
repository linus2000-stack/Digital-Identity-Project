Feature: Verify user particulars and account
  As a non-governmental organization(NGO) personnel approached to help provide verification for an undocumented user's EnableID account on the 4th July 2024,
  I want to view information from his/her EnableID account to help determine the authenticity of his/her identity
  So that I can mark the personal particualrs of his/her EnableID account as verified.

Background:
  Given a user particular exists with unique ID "3451765" and 2FA code "347628"

Scenario: Going to my own "NGO" page
  Given I am on the "Login" page
  When I press the "I am a NGO" button
  Then I should see a set of different NGO buttons 
  When I press the NGO "Gebirah" card
  Then I should be redirected to the NGO "Gebirah" page
  And I should see "Hello, Gebirah"

Scenario: Retrieving undocumented user's EnableID personal particulars
  Given I am already on my NGO "Gebirah" page
  When I key in the undocumented user's unique EnableID number: 3451765
  And I key in a 6 digit code that is seen on his/her EnableID: 347628
  And I press "Check" button
  Then I should be redirected to the "User Verification" page and see "EnableID Verification"
  And I should see his/her EnableID card
  And I should see "3451765"
  And I should see "Verify" button

Scenario: Wrong Unique ID number
  Given I am already on my NGO "Gebirah" page
  When I key in the undocumented user's unique EnableID number: 121111111
  And I key in a 6 digit code that is seen on his/her EnableID: 958523
  And I press "Check" button
  Then I should see "User not found. Please check your Unique ID and 2FA Code."

Scenario: Mark undocumented user's EnableID status as verified, then check the account
  Given I am on "User Verification" page
  When I press the "verify" button
  Then I should see "Verification successful for unique ID: 3451765."
  Then I should be redirected to the NGO "Gebirah" page