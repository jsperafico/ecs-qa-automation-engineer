# FB1 - Protect /metrics endpoint

| Key                | Value          |
| ------------------ | -------------- |
| Category           | Secutiry       |
| Component          | Authentication |
| Suggested Priority | High           |
| Severity           | Critical       |
| Environment        | Local          |


## Description
  I will assume the usage of ***/metrics*** endpoint retrieves sensitive information and the imaginary documentation for the application is stating that it shouldn't be protected. Therefore, it is highly suggested to protect due its sensitive nature. Meaning, only when user is authenticated, it should be able to access such endpoint.
  
  For the time being, integration test on [authentication.feature](../functional.repository/src/test/resources/me/jsperafico/sap/assignment/integration/authentication.feature) was writen as is. In other words, it isn't assumed this Bug will be accepted.

## Steps to reproduce
  1) Using ***HTTP GET*** method on ***/metrics***
  2) Accepts the request event **without** authentication


---


# FB2 - Protect /logs/:id endpoint

| Key                | Value          |
| ------------------ | -------------- |
| Category           | Secutiry       |
| Component          | Authentication |
| Suggested Priority | High           |
| Severity           | Critical       |
| Environment        | Local          |


## Description
  I will assume the usage of ***/logs/:id*** endpoint retrieves sensitive information and the imaginary documentation for the application is stating that it shouldn't be protected. Therefore, it is highly suggested to protect due its sensitive nature. Meaning, only when user is authenticated, it should be able to access such endpoint.
  
  For the time being, integration test on [authentication.feature](../functional.repository/src/test/resources/me/jsperafico/sap/assignment/integration/authentication.feature) was writen as is. In other words, it isn't assumed this Bug will be accepted.

## Steps to reproduce
  1) Using ***HTTP GET*** method on ***/logs/:id***
  2) Accepts the request event **without** authentication


---


# FB3 - Processed status and metric may lead to unwanted assumptions

| Key                | Value      |
| ------------------ | ---------- |
| Category           | Functional |
| Component          | Logs       |
| Suggested Priority | Low        |
| Severity           | Low        |
| Environment        | Local      |


## Description
  Assuming the **Processed** status was purposily chosen as indicator of success during intial Software Analysis. Hereby I challenge this decision since it may cause unwanted assumption. Whenever a log is submitted through ***POST /logs***, it stays in the state of ***QUEUED***. Once logically processed, regardless if any issues had occured, the entity was processed. Hence the confusion.

  It is highly suggested for the state on this entity to be changed from ***PROCESSED*** to ***SUCCESSFUL*** or any other affirmative word the team feels suitable.

## Steps to reproduce
  1) Authenticate ***/auth/token***
  2) Using ***HTTP POST*** method on ***/logs***
  3) Returns the ***QUEUED*** status
  4) After a wait time over 5 seconds
  5) Retrieving the information through ***HTTP GET*** method on ***/logs:id***
  6) Returns the ***PROCESSED*** status
  7) Retrieving the information through ***HTTP GET*** method on ***/metrics***
  8) Returns the ***PROCESSED*** field, that doesn't indicate - logically - how many entries were processed regardless of their status.
