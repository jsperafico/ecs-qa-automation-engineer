# NFB1 - Performance Test can't assert Application Under Test global throughput

| Key                | Value         |
| ------------------ | ------------- |
| Category           | Configuration |
| Component          | Application   |
| Suggested Priority | High          |
| Severity           | High          |
| Environment        | Local         |


## Description

  It is totally understandable that Rate Limit can be changed. Specially considering that during the Technical Interview, the interviewers established that I do have the freedom to change it at will to play around with diferent limits. Although, in real life situation we often don't have this luxury.

  Rate limit set at [index.js line:28](../logging-backend/index.js)

  Having a rate limit of 100 requests/min that automatically rejects incomming requests once quota was reached, unables to properly evaluate the overall metrics, regardless of how many pod/containers:

  - Real bottlenecks in the infrastructure
  - Tail latency under load
  - Latency and throughput become meaningless

  If, by any chance, the rate limit was established per request ***and***:
  
  1. based on production metrics obtained by [Honeycomb](https://www.honeycomb.io/)
  2. the application under test is a brand new app without any prior history of execution.

  Then it would be possible to provide meaningful insights on how well the application runs.

  My last argument to not increase the rate limit for this application is: "There is no way of telling on what infrastructure this application runs. Therefore, I will assume the current rate limit is constrained due hardware limitations."

## Steps to reproduce

  N/A


---