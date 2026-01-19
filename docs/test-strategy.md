# Technical Interview Assignment Test Strategy #

This document provides a high-level guide for test activities and quality evalutations within the **Logging Backend** application. It defines the overall test approach to ensure the delivered software meets established quality standards and business expectations.

The test strategy outlines the scope and objectives of testing, applicable test types and levels, and the roles and responsibilities involved in the testing process. It serves as a shared reference for all stakeholders, including developers, testers, project managers, and business representatives, promoting a common understanding of how quality is planned, evaluated, and maintained throughout the project.

## Terminology

The following terms are used in this document and are defined here for clarity and consistency.

| Term              | Short Definition                                                                                                          |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **OKR**           | Objectives and Key Results used to align teams on measurable quality and delivery goals.                                  |
| **SLA**           | Service Level Agreement used to establish reliable and measurable statistics on a contract between consumer and provider. |
| **Quality**       | The degree to which a product meets requirements, user expectations, and business goals.                                  |
| **Processes**     | Structured activities and rules followed to build, test, and deliver software consistently.                               |
| **AUT**           | Application Under Test being the focus of the test strategy.                                                              |
| **Test Plan**     | A document that defines test objectives, scope, approach, schedule, responsibilities and Test Cases.                      |
| **Test Case**     | A set of conditions, inputs, and expected results used to verify a specific behavior.                                     |
| **Quality Gates** | Checkpoints used to verify that defined quality criteria are met before proceeding.                                       |
| **Bugs**          | Technical flaws in the software that cause incorrect or unexpected results.                                               |
| **Severity**      | The level of impact a bug has on system functionality or user experience.                                                 |
| **Priority**      | The order in which a bug should be fixed based on business importance.                                                    |
| **Risks**         | Potential events or conditions that may negatively affect quality, schedule, or scope.                                    |
| **KPI**           | Key Performance Indicator used to measure testing effectiveness and quality performance.                                  |

## Test Pyramid

The Test Pyramid is a model that guides how to structure and balance tests to achieve fast, reliable, and cost-effective feedback. Often it is portraited without the combination of different groups of test (Functional and Non-Functional). Also, usually contains a generic layout that doesn't apply correctly to a specific context. This being said, the image bellow, presents a custom tailored visualization for this specific project. 

![Test Pyramid](images/testpyramid.png)

The depiction above, still follows the general idea of a Test Pyramid being:

- Higher it's position: requires ***more*** computational resources being ***complex*** and ***costly*** to create and run a given test case.
- Lower it's position: requires ***less*** computational resources being ***simpler*** and ***cheap*** to create and run a given test case.
- Wider the block: tends to be ***cheaper*** to cover business rules and thus have ***higher*** test count.
- Slimmer the block: tends to be ***expesive*** to cover business rules and thus have ***lower*** test count.

### Functional Testing

A Functional Test verifies that the system behaves according to defined requirements by validating features, inputs, and expected outputs.
There are several different types that have been ommited during this document, simply because goes out of scope. Among them, are Unit tests, Component Tests, Contract tests and User Acceptance Tests.

#### Integration Test

An integration test verifies that multiple components or services work together correctly, focusing on their interactions, data flow, and integration points rather than isolated functionality.

#### E2E Test

Validates complete user or system workflows by testing the application from start to finish across all integrated components. It requires the Application Under Test to be up and running with all its dependencies.

### Non-Functional Testing

A Non-Functional Test evaluates how the system performs under specific conditions, focusing on attributes such as performance, security, reliability, and usability, being the last not covered in this document due scope restrictions.

| Test Type            | One-Line Description                                                                                           |
| -------------------- | -------------------------------------------------------------------------------------------------------------- |
| **Performance Test** | Measures system responsiveness, throughput, and stability under expected workloads.                            |
| **Scalability Test** | Evaluates the system’s ability to handle increased load by scaling users, data, or resources.                  |
| **Reliability Test** | Assesses the system’s ability to operate correctly and consistently over time without failure.                 |
| **Security Test**    | Identifies vulnerabilities and verifies that the system protects data, access, and functionality from threats. |

## Test Architecture

On a high-level functional and non-functional tests will be segregated on different repositories. Aiming to easily isolate proper test execution and the relevant dependencies. Consequentially, enable the dev team to easily hook into their own project pipelines whenever it feels necessary.

This being said, although the repositories are different, the underlying Test Execution Infrastructure will be the same. Meaning:

| Component                  | Description                                                                                  |
| -------------------------- | -------------------------------------------------------------------------------------------- |
| **Key Vault**              | Secure storage for secrets, usernames, passwords, and sensitive configuration data.          |
| **Database**               | Stores test plan reports, execution statistics, and audit-related testing data.              |
| **Prometheus Server**      | Collects metrics from the test infrastructure to detect performance bottlenecks.             |
| **Kubernetes Cluster**     | Orchestrates distributed test executions across multiple target environments.                |
| **Kubernetes Pod**         | Executes test cases and exposes execution and resource metrics via a Prometheus agent.       |
| **Allure Report**          | Example reporting library that provides fast, local feedback for functional test executions. |
| **Grafana**                | Centralized monitoring and reporting platform with customizable dashboards for test metrics. |
| **Virtual Network (VNet)** | Secure network bridge between the test infrastructure and the Application Under Test.        |
| **Chatbot API**            | Sends automated summaries and notifications based on test execution results.                 |

The relationship of components described above, can be seen at:

![Test Architecture](images/architecture.png)

As can be seen, there is no mention about NICs, VM Sets, Persistent Discs, etc. This is chosen to not only simplify the visualization and also acknowledge my limitations on the aspect of DevOps. Surely, I will miss out a obvious cruacial component, so I chosen to keep it only where I am knowledgable at.

On the aspect of [functional](../functional/) and [non-functional](../non-functional/) repositories. The following technology stack was chosen:

| Category           | Component            | Selection                 | Short Description                                                                        |
| ------------------ | -------------------- | ------------------------- | ---------------------------------------------------------------------------------------- |
| **Functional**     | Programming Language | **Java**                  | Primary language due to strong team expertise for the targeted test types.               |
| **Functional**     | Test Library         | **Karate**                | Stable, API-focused testing tool; support for other test types is still evolving.        |
| **Functional**     | Local Test Report    | **Allure Report**         | Lightweight and reliable reporting tool for evaluating local functional test executions. |
| **Non-Functional** | Programming Language | **Java**                  | Primary language due to strong team expertise for the targeted test types.               |
| **Non-Functional** | Test Tool            | **JMeter**                | Open-source, Java-based tool for load testing and performance measurement.               |
| **Non-Functional** | Local Test Report    | **JMeter Native Reports** | Built-in reporting used for local non-functional test execution analysis.                |

Finally, as can be seen, most of the technology stack across the Test Execution Infrastructure is Open Source and roalty-free for commercial use. That doesn't necessarily means that the underlying components are also free. To name a few VMs, Disks and Network. All of them have a cost associated with it. Every cloud provider has its own costs and limitations that change yearly, making hard to precisely estimate how much it will cost. Nonetheless, prior experience providing a infrastructure simmilar to this one, presented the cost of under €3K/month by the end of 2024. 

## Application Under Test

The Application Under Test (AUT) being topic of this Test Strategy, is composed only by a Backend application. It contains a subset of endpoints of whom represents a logging platform backend. All the traits related to its functionality and how well it performs are consider under scope. It is consider as out of scope, are future 3rd party service integrations of whom this maintainer team isn't accountable for.

### Links

- [App Documentation](../logging-backend/README.md)
- [Repositories](../logging-backend/)

### Caveats

- For now, the Application Under Test isn't hosted anywhere. Every test will be triggered locally, having the AUT self-hosted alongside with it. Such approach is highly disencouraged since its heavily impacts test results reliability and consistency.

## Alignment

The Interviewer will take the entire ownership of the test process and is composed by strategyzing, planning, automating, executing and reporting.
The AUT should and will not be modified in any capacity. To best represent a test execution, test cases will be aggregated within a Test Plan, providing a clear vision of what is being tested on a given period. Therefore, each execution should clearly represents if quality standards driven by KPIs, often established through SLAs and highly suggested from OKRs. 

### Involved OKRs

| Objective                                              | Key Results (Derived from KPIs)                      |
| ------------------------------------------------------ | ---------------------------------------------------- |
| **Ensure product stability and prevent regressions**   | KR1: Maintain **0% regression new bugs rate**        |
| **Ensure product stability and prevent regressions**   | KR2: Keep **prior regression bugs unresolved ≤ 1%**  |
| **Deliver reliable and resilient system behavior**     | KR1: Maintain **response error rate < 1%**           |
| **Deliver reliable and resilient system behavior**     | KR2: Achieve **system recoverability time < 30s**    |
| **Provide fast and consistent performance**            | KR1: Maintain **median response time < 1s**          |
| **Provide fast and consistent performance**            | KR2: Maintain **99th percentile response time < 2s** |
| **Support business growth through quality experience** | KR1: Achieve **new clients conversion rate > 10%**   |

### KPIs

| KPI                                   | Description                                                            | Target            |
| ------------------------------------- | ---------------------------------------------------------------------- | ----------------- |
| Regression New Bugs Rate              | Percentage of new defects introduced by regression testing.            | **0%**            |
| Prior Regression Bugs Resolution Rate | Percentage of previously known regression bugs that remain unresolved. | **≤ 1% (if any)** |
| Response Error Rate                   | Percentage of failed or erroneous responses during normal operation.   | **< 1%**          |
| Estimated Recoverability Time         | Time required for the system to recover after a failure.               | **< 30s**         |
| Median Response Time                  | Typical system response time under normal load.                        | **< 1s**          |
| 99th Percentile Response Time         | Worst-case response time experienced by 99% of requests.               | **< 2s**          |
| New Clients Conversion Rate           | Percentage of new users successfully converted to active clients.      | **> 10%**         |

### Display the team composition and RACI matrix

| Activity                                                     | QA  | Dev | PO  | DevOps | Stakeholders |
| ------------------------------------------------------------ | --- | --- | --- | ------ | ------------ |
| **Provide documentation and application for the assessment** | R   | C   | A   | C      | I            |
| **Propose Test Strategy**                                    | R   | C   | A   | C      | I            |
| **Create Test Plan**                                         | R   | C   | A   | I      | I            |
| **Create Functional Test Automation**                        | R   | C   | I   | C      | I            |
| **Create Non-Functional Test Automation**                    | R   | C   | I   | C      | I            |
| **Execute Test Plan**                                        | R   | C   | I   | C      | I            |
| **Provide Test Report**                                      | R   | I   | A   | I      | I            |

## Reporting

The test report should ideally be automatically received on preferred communication channel as soon as a test plan finishes its execution. This message, should contain the minimum amount of relevant information to a desired group, often present on the RACI matrix above. Also, a link to a detailed report version should be accompanied with that message already mentioned. This link should be easily accessible to relevant parties. 

### Quality Gates

| Quality Gate                  | Condition                                       | Pass Criteria            |
| ----------------------------- | ----------------------------------------------- | ------------------------ |
| **Regression Stability Gate** | No new defects introduced by regression testing | **0%**                   |
| **Regression Cleanup Gate**   | Previously identified regression bugs addressed | **> 10% (if any exist)** |
| **Performance Baseline Gate** | Typical system response under normal load       | **< 1.5s**               |
| **Performance Tail Gate**     | Worst-case response time for 99% of requests    | **< 5s**                 |
| **Reliability Gate**          | Percentage of failed or erroneous responses     | **< 3%**                 |

The consequences of not being able to meet the quality gates represents Risks that should be taken in consideration whenever proceeding with a delivery or not.

### Bug Reporting

A bug should be reported as soon as it is identified and reproducible. It should clearly capture both severity and priority, as they describe different aspects of a defect and help teams make effective decisions.

Severity describes the impact of a bug on the system. It reflects how badly the defect affects functionality, performance, stability, or user experience, regardless of when it will be fixed.

Priority indicates the urgency of fixing the bug. It is driven by business needs, release timelines, and customer impact.

By using both severity and priority in bug reports, teams can accurately assess risk, align technical impact with business urgency, and plan fixes more effectively.