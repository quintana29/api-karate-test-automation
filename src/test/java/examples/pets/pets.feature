



  Scenario: Update a pet
    Given request { "name": "Bingo3", "type": "Perro", "age": 1 }
    When method post
    Then status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And request { "name": "Bingo8", "type": "Gato", "age": 10 }
    And method put
    Then status 200
    And match $.data.name == "Bingo8"
    And match $.data.type == "Gato"


  Scenario: Update partially a pet
    Given request { "name": "Bingo3", "type": "Perro", "age": 1 }
    When method post
    Then status 201
    And def petId = $.data.id
    When url "http://localhost:3000/pets/" + petId
    And request { "name": "Lazzy" }
    And method patch
    Then status 200
    And match $.data.name == "Lazzy"

  Scenario: Delete a pet
    Given request { "name": "Bingo3", "type": "Perro", "age": 1 }
    When method post
    Then status 201
    And def petId = $.data.id
    And url "http://localhost:3000/pets/" + petId
    When method delete
    Then status 204

  Scenario Outline: Create a new pet
    Given request { "name": "#(name)", "type": "#(type)", "age": #(parseInt(age)) }
    When method post
    Then status 201
    And match $.message contains "Pet created"
    Examples:
      | name   | type  | age |
      | Zoro 1 | Perro | 1   |
      | Zoro 2 | Gato  | 2   |
      | Zoro 3 | Loro  | 3   |
      | Zoro 4 | Oveja | 4   |
      | Zoro 5 | Perro | 5   |

  Scenario Outline: Create a new pet with <description>
    Given request { "name": "<name>", "type": "<type>", "age": <age> }
    When method post
    Then status <expectedStaus>
    And match $.message contains "<expectedMessage>"
    Examples:
      | name              | type  | age | description        | expectedStaus | expectedMessage |
      | Zoro 23232323sss1 | Perro | 1   | long name          | 201           | Pet created     |
      | Zoro 2  !!!       | Gato  | 2   | invalid characters | 201           | Pet created     |

  Scenario: Create a new dog reading an external file
    * def createANewPetRequest = read('classpath:requests/createANewPet.json')
    * def successfullPetCreationResponse = read('classpath:responses/successfullPetCreationResponse.json')

    Given request createANewPetRequest
    When method post
    Then status 201
    And match $.message contains "Pet created"
    And match response == successfullPetCreationResponse


  Scenario: Create a new dog reading an external file as template
    * def name = 'Testing'
    * def type = 'Perro'
    * def age  = 1

    * def createANewPetRequest = read('classpath:requests/createANewPetTemplate.json')
    * def successfullPetCreationResponse = read('classpath:responses/successfullPetCreationResponse.json')

    Given request createANewPetRequest
    When method post
    Then status 201
    And match $.message contains "Pet created"
    And match response == successfullPetCreationResponse

  Scenario Outline: Create a new pet reading an external file as template outline

   # Importante: Estas variables se cargan EN CADA iteración del Examples
    * def createANewPetRequest = read('classpath:requests/createANewPetTemplate.json')
    * print 'JSON generado para ' + name + ':', createANewPetRequest
    * def successfullPetCreationResponse = read('classpath:responses/successfullPetCreationResponse.json')

    Given request createANewPetRequest
    When method post
    Then status 201
    And match $.message contains "Pet created"
    And match response == successfullPetCreationResponse

    Examples:
      | name    | type  | age |
      | Testing | Perro | 1   |
      | Rex     | Dog   | 3   |
      | Luna    | Gato  | 2   |


