package me.jsperafico.sap.assignment;

import com.intuit.karate.junit5.Karate;

class AllTestsRunner {

  @Karate.Test
  Karate integration() {
    return Karate.run().tags("@integration")
        .relativeTo(getClass());
  }

  @Karate.Test
  Karate e2e() {
    return Karate.run().tags("@e2e")
        .relativeTo(getClass());
  }
}
