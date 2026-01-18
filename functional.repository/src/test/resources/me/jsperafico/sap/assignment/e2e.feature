    @e2e
Feature:
    As an Authenticated User
    I want to visualize different logs
    In order to follow the statistics of a given application

  Background:
    * url baseUrl

    Given path '/auth/token'
    When method post
    Then status 200
    And def auth = response
    * def authHeader = 'Bearer ' + auth.token
    * configure headers = { Authorization: '#(authHeader)' }

    @regression
  Scenario: must successfully retrieve insert and retrieve log affecting metrics
    Given path '/metrics'
    When method get
    Then status 200
    * def baseline = response
    
    Given path '/logs'
    When method post
    Then status 202
    And match response contains {correlationId: '#!'}
    * def uuid = response.correlationId

    Given path '/logs/' + uuid
    When method get
    Then status 200
    And match response.status == 'QUEUED'
    * def initialStatus = response.status

    Given path '/metrics'
    When method get
    Then status 200
    And assert response.queued > baseline.queued

    * configure retry = { count: 3, interval: 1000 }
    * retry until response.status != initialStatus
    Given path '/logs/' + uuid
    When method get
    Then status 200

    Given path '/metrics' 
    When method get
    Then status 200
    # INFO: Can't make this assertion since 'processed' here means {status: 'PROCESSED'}
    #       index.js - line: 74
    # And assert response.processed > baseline.processed
