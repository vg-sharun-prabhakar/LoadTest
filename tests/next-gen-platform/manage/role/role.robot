*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***

*** Test Cases ***
Create a Role
    [Documentation]    This test case to create role.
    [Tags]    TCR01 RoleTag

    #this line hides the sensitive data to be logged
    Set Log Level    WARN 

    ${roleData}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json

    ${URL}    Set Variable    ${roleData['URL']}
    ${postBody}    Set Variable    ${roleData['PostBody']}
    ${roleName}    Set Variable    ${roleData['PostBody']['roleName']}
    ${RANDOM_STRING}   Generate Random String    10
    Set Suite Variable    ${random_roleName}     ${roleName}${RANDOM_STRING}
    Set To Dictionary    ${postBody}    roleName    ${random_roleName}  

    #Set Log Level    WARN
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${postBody}

    #this keyword is used to cleanup the data from the DB.
    #Execute SQL Commands    rolename    ${roleName}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}     ${roleName}${RANDOM_STRING} has been created
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}   

Get role detail by roleName
    [Documentation]    This test case to get the role detail using rolename.
    [Tags]    TCR02

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${random_roleName}    ${headers}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['roleName']}      ${random_roleName}  

    Set Suite Variable    ${roleId}    ${response.json()['data'][0]['roleId']}

    Log To Console    Response JSON: ${response.json()}

View the Role Detail
    [Documentation]    This test case to get the role.
    [Tags]    TCR03

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${roleId}   ${headers}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Integers    ${response.json()['roleId']}    ${roleId}

    Log To Console    Response JSON: ${response.json()}

Update the Role
    [Documentation]    Updates the Role
    [Tags]    TCR04

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}
    ${putBody}    Set Variable    ${variables['PutBody']}

    #Modify the specific key-value pair
    Set To Dictionary    ${putBody}    roleId     ${roleId}
    Set To Dictionary    ${putBody}    roleName   ${random_roleName}
    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${putBody}

    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    #Verify Response String    ${response.content}    ${roleName} has been edited

    Log To Console    ${putBody}
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the Role
    [Documentation]    Deactivates the Role
    [Tags]    TCR05
    
    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}
    ${statusChangePayload}    Set Variable   ${variables['StatusChangePayload']}
    Set To Dictionary    ${statusChangePayload}    Id    ${roleId}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${statusChangePayload}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${random_roleName} has been deactivated

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the Role
    [Documentation]    Reactivates the Role
    [Tags]    TCR06
    
    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}
    ${statusChangePayload}    Set Variable   ${variables['StatusChangePayload']}
    Set To Dictionary    ${statusChangePayload}    Id    ${roleId}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${statusChangePayload}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${random_roleName} has been reactivated

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the Role
    [Documentation]    Reactivates the Role
    [Tags]    TCR07

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}
    ${statusChangePayload}    Set Variable   ${variables['StatusChangePayload']}
    Set To Dictionary    ${statusChangePayload}    Id    ${roleId}
    
    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${statusChangePayload}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${random_roleName} has been terminated

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get System Values
    [Documentation]    To get the system values
    [Tags]    TCR08
    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\role\\role.json
    ${URL}    Set Variable    ${variables['URL']}
    ${column}    Set Variable    name

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetSystemValues?column=${column}    ${headers}

    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()[0]['value']}      name













    




























