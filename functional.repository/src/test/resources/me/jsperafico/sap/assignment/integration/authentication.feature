    @integration
Feature:
    As an individual
    I want to try to use Log Application
    So I check if I have access to it

  Background:
    * url baseUrl
    * header Connection = 'close'

    @regression
  Scenario: must succeed retrieve metrics from Log Application without Authentication
    Given path '/metrics'
    When method get
    Then status 200

    @regression
  Scenario: must succeed retrieve a log from Log Application without Authentication
    Given path '/logs/1'
    When method get
    Then status 404

    @regression
  Scenario: must fail to post log to Log Application without authentication
    Given path '/logs'
    When method post
    Then status 401
  
    @regression
  Scenario: must fail to post log to Log Application if token expires
    Given path '/auth/token'
    When method post
    Then status 200
    And def auth = response

    * header Authorization = 'Bearer ' + auth.token

    Given path '/logs'
    And request { }
    When method post
    Then status 202

    * def uuid = response.correlationId
    * eval java.lang.Thread.sleep(6000)

    Given path '/logs'
    And request { }
    When method post
    Then status 401

