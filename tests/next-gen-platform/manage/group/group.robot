*** Settings ***
Resource    ../../../../resources/super.resource
# Library    ../../../../library/JSONManipulation.py

*** Variables ***
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/manage/api/v1/Group
*** Test Cases *** 
Creates the Group
    [Documentation]    This test case creates the Group.
    [Tags]    TCG01
    ${Group_Json_Path}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\group\\group.json
    ${CreateGroup}    Set Variable    ${Group_Json_Path["CreateGroup"]}
    ${auto_generated}    Generate Random String    8    [LETTERS]
    ${group_Name}    Set Variable    group_${auto_generated}
    Set Suite Variable    ${group_Name}
    Set To Dictionary    ${CreateGroup}    groupName    ${group_Name}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${CreateGroup}
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${group_Name} has been created
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get All Groups Details
    [Documentation]    This test case to get All groups details in batch.
    [Tags]    TCG02

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?batchNumber=1&batchSize=10&sortKey=task&sortOrder=desc&searchKey=&filterModels=[]    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    #Verify Response Field Is Not Empty    ${response}    ['data'][0]['id']           
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get all the Active Groups.
    [Documentation]    This test case to get all the Active Groups.
    [Tags]    TCG03

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetActive    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Group Details Using Group Name.
    [Documentation]    This test case to Get Group Details Using Group Name.
    [Tags]    TCG04

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${group_Name}   ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['groupName']}      ${group_Name}  

    Set Suite Variable    ${groupId}    ${response.json()['data'][0]['groupId']}
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

View the Group Detail
    [Documentation]    This test case to View the Group Detail.
    [Tags]    TCD05

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${groupId}    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    groupName    ${group_Name}
    
    Set Suite Variable    ${groupTypeId}    ${response.json()['groupTypeId']}
    Set Suite Variable    ${groupType}    ${response.json()['groupTypeText']}
    Set Suite Variable    ${groupNumber}    ${response.json()['groupNumber']}
    ${users}=    Extract Json Value To Array    ${response.content}    users    userId
    Set Suite Variable    ${users}
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.json()}
    Log To Console    users: ${users}

Retrieves Details of All Groups Along With The Count of Users in Each Group.
    [Documentation]    This test case retrieves details of all groups along with the count of users in each group.
    [Tags]    TCG06

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetGroupsWithUserCount   ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the Group
    [Documentation]    This test case to Update the Group.
    [Tags]    TCD07

     ${createFormBody}    Set Variable    {"groupId":${groupId},"groupTypeId":${groupTypeId},"groupType":"${groupType}","groupName":"${group_Name}","description":"test automation","comments":"test automation","groupStatusText":"ACTIVE","id":${groupId},"groupUsers":${users}}
    ${createFormBodyDict}=    Evaluate    json.loads("""${createFormBody}""")    json
    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}     ${createFormBodyDict} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${group_Name} has been edited
          
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the Group
    [Documentation]    This test case to deactivate the Group.
    [Tags]    TCD06

    ${PAYLOAD}     Create Dictionary    id=${group_id}    comments=test Automation    esignReason=""

    Set Suite Variable    ${changeStatus_payload}    ${PAYLOAD}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${changeStatus_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${groupNumber}-${group_Name} has been deactivated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the Group
    [Documentation]    This test case to Reactivate the Group.
    [Tags]    TCD07

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${changeStatus_payload} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${groupNumber}-${group_Name} has been reactivated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the Group
    [Documentation]    This test case to Terminate the Group.
    [Tags]    TCD08


    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${changeStatus_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${groupNumber}-${group_Name} has been terminated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}



