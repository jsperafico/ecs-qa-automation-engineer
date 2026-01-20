
# QA Automation Engineer — Technical Interview Assignment

### Phase 1 — Test Strategy & Architecture

Delivered at [Test Strategy](docs/test-strategy.md).

---

### Phase 2 — End-to-End Automation

Delivered at [functional](functional.repository/) where [README.md](functional.repository/README.md) file provides insights on how to run locally. Nonetheless, running [docker-compose.yaml](docker-compose.yaml) file contains a service called ***functional*** that executes the test and provide you with results. Identified bugs were reported at [Functional Bugs](bugs/Functional.md) file.

---

### Phase 3 — Performance & Stress Testing

Delivered at [non-functional](non-functional.repository/) where [README.md](non-functional.repository/README.md) file provides insights on how to run locally. Nonetheless, running [docker-compose.yaml](docker-compose.yaml) file contains a service called ***jmeter*** that executes the test and provide you with results. Identified bugs were reported at [Non-Functional Bugs](bugs/Non-Functional.md) file.

---

### Phase 4 — Security QA Validation

Automated Integration tests can be found at [logs.feature](functional.repository/src/test/resources/me/jsperafico/sap/assignment/integration/logs.feature) and [authentication.feature](functional.repository/src/test/resources/me/jsperafico/sap/assignment/integration/authentication.feature.feature). Mind you, it isn't extreamely complex:

- A simple content boundaries validation was implemented whenever a log is inserted with a given content length.
- Assessment of critical endpoints being exposed without authentication, such as ***/metrics*** and ***/logs/:id***. Of whom there are bugs related to that.

---

### Phase 5 — CI/CD & Quality Gates

Conceptually delivered at [Test Strategy](docs/test-strategy.md).
KPIs implemented only for non-functional tests as could be seen at [Non-Functional results folder](non-functional.repository/results/) once the test is finished.

Finally, the way to trigger the tests cloud be through schedule for nightly runs or hooks from one repository to another.

Nightly run: serve the purpose of provide fresh results to the dev team. Often consfigured to run as regression on a QA environment.
Hook run: triggered towards specific environment depending of the deployment realized.

![Architecture](docs/images/architecture.png)

---

### Phase 6 — Regression & Reporting

Non-Functional Test report available at [Grafana Url](http://localhost:5000/d/b4kP_KoMzasadasdasd123).
Functional Test report available through ***allure***, but in the future also available in grafana.
Bugs reported at [bugs folder](bugs/).

---

