Feature: Add new blog entry
  In order to add a new blog entry
  As a admin

    Background:
      Given I am logged in as admin
      And the blog entry "orangey" exists
      And I visit the blog
      And I click "orangey"
      And I click "Edit"

    Scenario: Edit blog entry
      When I fill in "Title" with "Blubb"
      And I fill in "Text" with "Heya"
      And I press "Save"

      Then I should see the header "Blubb"
      And I should see "Heya"

    Scenario: Edit blog entry without title
      When I fill in "Text" with "Hooray Pizza"
      And I fill in "Title" with ""
      And I press "Save"

      Then the "Title" field should have the "can't be blank" error
      And I fill in "Title" with "News!"
      And I press "Save"

      Then I should see the header "News!"
      And I should see "Hooray Pizza"

    Scenario: Edit blog entry without text
      When I fill in "Text" with ""
      And I press "Save"

      Then the "Text" field should have the "can't be blank" error
      And I fill in "Text" with "Yay"
      And I press "Save"

      Then I should see the header "orangey"
      And I should see "Yay"
