*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/manage/api/v1/GroupType

*** Test Cases ***
Get all the GroupTypes
    [Documentation]    This test case to get all the grouptype.
    [Tags]    TCGT01

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetGroupTypes    ${headers}    
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}
