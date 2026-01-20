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
  
  Scenario: must not be able to insert a log over 500 characters long
    Given path '/logs'
    And request { "Lorem": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibu"}
    When method post
    Then status 202
    And match response contains {correlationId: '#!'}

    * def first = response.correlationId

    Given path '/logs/' + uuid
    When method get
    Then status 200
    And match response.status == 'FAILED'
    # Message content shouldn't be asserted, since we are testing if the logic is correct.  
  