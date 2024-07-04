Feature: Verify user particulars and account
  As a non-governmental organization(NGO) personnel approached to help provide verification for an undocumented user's EnableID account,
  I want to view information from his/her EnableID account to help determine the authenticity of his/her identity
  So that I can mark the personal particualrs of his/her EnableID account as verified.

Scenario: Empty fields on “Enter Particulars” page
  Given I am on the “Enter Particulars” page
  Then I should see the following fields:  