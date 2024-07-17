Feature: Access and interact with common bulletin board
  As a non-governmental organization(NGO) personnel
  I want to access the common bulletin board and have a space to broadcast messages
  So that I can view and interact with posts from other NGOs and upload my own NGO's posts

Background:
  Given I am already on the NGO "Gebirah" page

Scenario: Viewing the common bulletin board
  When I press the "Bulletin Board" button
  Then I should be redirected to the bulletin board page
  And I should see posts from other NGOs

Scenario: Broadcasting a message to the common bulletin board
  When I press the "Broadcast Message" button
  Then I should be redirected to the broadcast message page
  And I should see a form to enter my message
  When I fill in the form and press the "Submit" button
  Then my message should be posted on the common bulletin board
  And I should see a confirmation message "Message broadcasted successfully"