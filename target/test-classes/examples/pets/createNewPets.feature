Feature: Create new pets

  Background:
    * url baseUrl
    * path 'pets'

  @create_successful_pet
  Scenario: Create a new dog
    Given request {"name": "Bingo3","type": "Perro","age": 1}
    When method post
    Then status 201
    And match $.message contains "Pet created"

    * def petId = $.data.id

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
