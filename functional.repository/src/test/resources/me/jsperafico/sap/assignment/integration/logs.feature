    @integration
Feature: 
    As an Authenticated User
    I want to be able to access logs
    In order to take a cohesive decision business-wise

  Background:
    * url baseUrl

    Given path '/auth/token'
    When method post
    Then status 200
    And def auth = response
    * def authHeader = 'Bearer ' + auth.token
    * configure headers = { Authorization: '#(authHeader)' }

    @regression
  Scenario: must be able to successfully insert a log returning a correlationId
    Given path '/logs'
    And request { }
    When method post
    Then status 202
    And match response contains {correlationId: '#!'}

    @regression
  Scenario: must be able to successfully insert multiple logs with different correlationIds
    Given path '/logs'
    And request { }
    When method post
    Then status 202
    And match response contains {correlationId: '#!'}
    
    * def first = response.correlationId

    Given path '/logs'
    And request { }
    When method post
    Then status 202
    And match response.correlationId != first
  
    # TODO: Create scenarios in order to cover log retrieval endpoint