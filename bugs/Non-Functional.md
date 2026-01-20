# NFB1 - Memory Leak

| Key                | Value         |
| ------------------ | ------------- |
| Category           | Configuration |
| Component          | Application   |
| Suggested Priority | High          |
| Severity           | High          |
| Environment        | Local         |


## Description

  During the execution of [TC02](../non-functional.repository/TC02-must_evaluate_memory_leak.jmx), a potential memory leak was identified.

  Generating multiple log entries via [POST /logs](/logs) increases the application's memory usage. While some memory growth is expected during normal operation, the observed increase appears excessive considering the behavior of the Application Under Test (AUT).

  Assessment:
    - Long-past log entries should not significantly impact the application's memory usage.
    - The memory growth observed suggests a potential leak rather than normal transient memory consumption.

## Steps to Reproduce

  1. Execute [TC02](../non-functional.repository/TC02-must_evaluate_memory_leak.jmx).
  2. Generate multiple log entries using [POST /logs](/logs).
  3. Monitor the application's memory usage.

---