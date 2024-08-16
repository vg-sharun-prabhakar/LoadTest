*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/entity/api/v1/EntityGroup/
*** Test Cases *** 
Get Parent Types
    [Documentation]    This test case to Get Parent Types.
    [Tags]    TCC01

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetNextUniqueId    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    #Verify Response Field    ${response}    message    Parent types retrieved successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}