package examples.pets;

import com.intuit.karate.junit5.Karate;

public class SearcPetsRunner {
    @Karate.Test
    Karate testSearcPets() {
        return Karate.run("searchPets").relativeTo(getClass());
    }
}
