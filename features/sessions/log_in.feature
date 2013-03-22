Feature: Log In
  In order to use protected areas of the site
  As a user
  I want to be able to log in

    Scenario: User is not signed up
      Given I do not exist as user
      When I go to the log in page
      And I fill in "Name" with "joe"
      And I fill in "Password" with "hello world!"
      And I press "Login"
      Then I should see an invalid login message
      And I should be logged out

    Scenario: User is signed up
      Given I do exist as user
      When I go to the log in page
      And I fill in "Name" with "joe"
      And I fill in "Password" with "hello world!"
      And I press "Login"
      Then I should see a successful login message
      And I should be logged in

    Scenario: User doesn't fill in name
      Given I do exist as user
      When I go to the log in page
      And I fill in "Password" with "hello world!"
      And I press "Login"
      Then I should see an invalid login message
      And I should be logged out

    Scenario: User doesn't fill in password
      Given I do exist as user
      When I go to the log in page
      And I fill in "Name" with "joe"
      And I press "Login"
      Then I should see an invalid login message
      And I should be logged out

    Scenario: User submits blank form
      Given I do exist as user
      When I go to the log in page
      And I press "Login"
      Then I should see an invalid login message
      And I should be logged out
