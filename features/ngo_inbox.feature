Feature: Manage inbox
  As a non-governmental organization(NGO) personnel
  I want to access my inbox
  So that I can view and manage messages from other NGOs or undocumented users

Scenario: Viewing inbox messages
  Given I am on the NGO "Gebirah" page
  When I press the "Inbox" button
  Then I should be redirected to my inbox
  And I should see a list of messages
  And I should be able to open and read messages
  And I should be able to reply to messages