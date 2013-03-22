Feature: Sign Up
  In order to use protected areas of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in

    Scenario: User signs up with valid data
      When I sign up with valid user data
      Then I should see a successful sign up message

    Scenario: User signs up without a name
      When I sign up without a name
      Then the Name field should have the is too short error

    Scenario: User signs up with a too short name
      When I sign up with a too short name
      Then the Name field should have the is too short error

    Scenario: User signs up with an invalid email
      When I sign up with an invalid email
      Then the Email field should have the is invalid error

    Scenario: User signs up with an alreay taken name
      Given a user with the same name exists
      When I sign up with valid user data
      Then the Name field should have the has already been taken error

    Scenario: User signs up without filling the password field in
      When I sign up without filling the password field
      Then the Password field should have the is too short error
      And I should not see a blank message
