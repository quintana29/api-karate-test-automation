package examples.pets;

import com.intuit.karate.junit5.Karate;

public class UpdatePetsRunner {
    @Karate.Test
    Karate testUpdatePets() {
        return Karate.run("updatePets").relativeTo(getClass());
    }
}
