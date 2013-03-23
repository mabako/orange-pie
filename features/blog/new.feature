Feature: Add new blog entry
  In order to add a new blog entry
  As a admin

    Background:
      Given I am logged in as admin
      When I click "Blog"

    Scenario: Add new blog entry
      When I click "New"
      And I fill in "Title" with "Blubb"
      And I fill in "Text" with "Heya"
      And I press "Save"

      Then I should see the header "Blubb"
      And I should see "Heya"

    Scenario: Add new blog entry without title
      When I click "New"
      And I fill in "Text" with "Hooray Pizza"
      And I press "Save"

      Then the "Title" field should have the "can't be blank" error
      And I fill in "Title" with "News!"
      And I press "Save"

      Then I should see the header "News!"
      And I should see "Hooray Pizza"

    Scenario: Add new blog entry without text
      When I click "New"
      And I press "Save"

      Then the "Title" field should have the "can't be blank" error
      Then the "Text" field should have the "can't be blank" error
      And I fill in "Title" with "Omnom!"
      And I fill in "Text" with "Yay"
      And I press "Save"

      Then I should see the header "Omnom!"
      And I should see "Yay"
