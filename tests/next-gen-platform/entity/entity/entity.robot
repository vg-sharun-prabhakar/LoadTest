*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/entity/api/v1/Entity/Create

*** Test Cases *** 
Create an Entity
    [Documentation]    This tests entity creation with valid payload.
    [Tags]    TCE01 PostEntityTag

    #this line hides the sensitive data to be logged
    Set Log Level    WARN 

    ${JSONFILEPATH}    Set Variable    ${EXECDIR}\\tests\\next-gen-platform\\entity\\entity\\entity-post-body.json
    ${keyList} =    Evaluate    ['entityName', 'entityNumber']
    Add Random Alphabet String To Json    ${JSONFILEPATH}    ${keyList}    20
    ${entityPostData}    Load JSON From File    ${JSONFILEPATH}
    ${entityName}    Set Variable    ${entityPostData['entityName']}

    #Set Log Level    WARN
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}    ${headers}    ${entityPostData}
    
    #this keyword is used to cleanup the data from the DB.
    #Execute SQL Commands    entityName    ${entityName}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${entityName} has been created
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}   

