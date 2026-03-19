package examples.pets;

import com.intuit.karate.junit5.Karate;

public class CreateNewPetRunner {
    @Karate.Test
    Karate tesCreateNewPets() {
        return Karate.run("createNewPets").relativeTo(getClass());
    }
}
