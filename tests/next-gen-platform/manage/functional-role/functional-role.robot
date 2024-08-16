*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${Id}    0
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/manage/api/v1/FunctionalRole

*** Test Cases ***
Create a FunctionalRole
    [Documentation]    This test case to create FunctionalRole.
    [Tags]    NGP-4963

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\functional-role\\functional-role.json
    ${Create_FunctionalRole}    Set Variable    ${variables["CreateFunctionalRole"]}
    ${auto_generated}    Generate Random String    length=8    chars=[LETTERS]
    ${functionalName}    Set Variable    functionalRole_${auto_generated}
    ${functionalPrefix}    Set Variable    Prefix_${auto_generated}
    Set Suite Variable    ${functionalName}
    Set Suite Variable    ${functionalPrefix}
    Set To Dictionary    ${Create_FunctionalRole}    functionalName    ${functionalName}
    Set To Dictionary    ${Create_FunctionalRole}    functionalPrefix    ${functionalPrefix}

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${Create_FunctionalRole}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${functionalName} has been created
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}   

Get FunctionalRole Details Using Functional Name
    [Documentation]    This test case to get FunctionalRole details using Functional name.
    [Tags]    Filter By Name

    #Get request    
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${functionalName}   ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['functionalName']}  ${functionalName}  

    Set Suite Variable    ${FunctionalRoleId}    ${response.json()['data'][0]['functionalRoleId']}
    Set Suite Variable    ${FunctionalRoleName}    ${response.json()['data'][0]['functionalName']} 
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get All FunctionalRole details
    [Documentation]    This test case to get all FunctionalRole details.
    [Tags]    NGP-4964

    #Get request    
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?batchNumber=1&batchSize=10&sortKey=task&sortOrder=desc&searchKey=&filterModels=[]    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

View the FunctionalRole Details
    [Documentation]    This test case to View the FunctionalRole Details.
    [Tags]    View FunctionalRole

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${FunctionalRoleId}    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field   ${response}    functionalName    ${FunctionalRoleName}
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the FunctionalRole
    [Documentation]    This test case to Update the FunctionalRole.
    [Tags]    NGP-4965

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\functional-role\\functional-role.json
    ${Update_FunctionalRole}    Set Variable    ${variables["UpdateFunctionalRole"]}
    Set To Dictionary    ${Update_FunctionalRole}    functionalRoleId    ${functionalRoleId}
    Set To Dictionary    ${Update_FunctionalRole}    functionalName    ${functionalName}
    Set To Dictionary    ${Update_FunctionalRole}    functionalPrefix    ${functionalPrefix}

    Set Suite Variable    ${Put Body}    ${Update_FunctionalRole}
    
    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}     ${Put Body} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${functionalName} has been edited    
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Active FunctionalRole
    [Documentation]    This test case retrieves FunctionalRole details using the functional role ID.
    [Tags]             Active FunctionalRoles

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetActive?id=${Id}    ${headers}

    # Verification/Assertions 
    Verify Response Code    ${response.status_code}    200

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate FunctionalRole
    [Documentation]    This test case deactivates a FunctionalRole.
    [Tags]    NGP-4966
    # Load the JSON data
    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\functional-role\\functional-role.json
    ${StatusChangePayload}    Set Variable    ${variables["StatusChangePayload"]}
    Set To Dictionary    ${StatusChangePayload}    id    ${functionalRoleId}

    Set Suite Variable    ${changeStatus_payload}    ${StatusChangePayload}

    # Send PUT request to deactivate the FunctionalRole
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}  ${changeStatus_payload} 

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200  
    Verify Response String    ${response.content}    ${functionalName} has been deactivated  

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate FunctionalRole
    [Documentation]    This test case reactivate a FunctionalRole.
    [Tags]    NGP-4967

    # Send PUT request to reactivate the FunctionalRole
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}  ${changeStatus_payload} 

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${functionalName} has been reactivated    

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate FunctionalRole
    [Documentation]    This test case terminate a FunctionalRole.
    [Tags]    NGP-4967

    # Send PUT request to terminate the FunctionalRole
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}  ${changeStatus_payload} 

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${functionalName} has been terminated    

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}