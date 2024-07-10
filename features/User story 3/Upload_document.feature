draft 1
Feature: User Uploading Documents
    As a undocumented individual  
    I want to upload my documents during registration
    So that I can have a digital copy of my documents stored
    so that it will be  accessible by me and NGO when needed

    Scenario: Going to "Upload Documents" page
        Given i am on "registration" page
        When i press "proceed to next page" button
        Then i should be directed to "Upload Document" Page
    
    Scenario: Uploading a Document 
        Given I am on the "Upload Document" page,
        When I drag a document file into the designated drop area,
        Then I should see the file name, file size, date of upload, a dropdown menu to select the type of document I am uploading displayed above the designated drop area,
        And I should have an option to view and remove the document 

    Scenario: Uploading an Unsupported File Type
        Given I am on the "Upload Document" page,
        When I select a file with an unsupported format,
        And drop the file,
        Then I should see an error message stating "Unsupported file type. Please upload a PDF, DOCX, or JPG file."

    Scenario: Uploading a File That Is Too Large
        Given I am on the "Secure Upload" page,
        When I select a file that exceeds the size limit,
        And I press the "Upload Securely" button,
        Then I should see an error message stating "File size exceeds the maximum limit of 5MB. Please upload a smaller file."

    Scenario: Verifying Uploaded Documents
        Given that my document has been successfully uploaded and I have received confirmation,
        When authorized personnel access my uploaded documents for verification,
        Then they should only be able to do so with my consent and appropriate security checks,
        And I should receive a notification that my documents are being reviewed.

