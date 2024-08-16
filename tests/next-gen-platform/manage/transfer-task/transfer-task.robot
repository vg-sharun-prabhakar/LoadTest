*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***


*** Test Cases ***
Get Batch Users details along with the available tasks
    [Documentation]    This test case to Get Batch Users details along with the available tasks.
    [Tags]    TCTT01
    ${roleData}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\transfer-task\\transfer-task.json
    Set Suite Variable    ${URL}   ${roleData['URL']}
    Set Suite Variable    ${put_payload}    ${roleData['TRANSFER_TASK_BODY']}
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?BatchNumber=1&BatchSize=10&sortKey=uniqueUserId&sortOrder=asc&searchKey=&filterModels=[]    ${headers} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Length Should Be    ${response.json()['data']}    10
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Modules
    [Documentation]    This test case to Get Modules.
    [Tags]    TCTT02

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetModules    ${headers} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    ${length}    Evaluate    len(${response.json()})
    IF  ${length} > 1
        Log To Console    true
    ELSE
        Fail
    END
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Task Types
    [Documentation]    This test case to Task Types.
    [Tags]    TCTT03

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetTaskTypes    ${headers} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    ${length}    Evaluate    len(${response.json()})
    IF  ${length} > 1
        Log To Console    true
    ELSE
        Fail
    END
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


Validate task can be transfered to the User
    [Documentation]    This test case to validate task can be transfered to the User.
    [Tags]    TCTT04


    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/ValidateTransferTasks    ${headers}    ${put_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    ${json_data}   Convert To Dictionary    ${response.json()}

    # Access the taskList and check the isValid attribute
    ${task_list}   Get From Dictionary    ${json_data}    taskList
    ${is_valid}    Get From Dictionary    ${task_list[0]}    isValid
    Should Be True    ${is_valid}
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Transfer task to the User
    [Documentation]    This test case to validate task can be transfered to the User.
    [Tags]    TCTT04


    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/TransferTasks    ${headers}    ${put_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Log To Console    Response JSON: ${response.content}
    Verify Response String    ${response.content}    Selected tasks(1) from Tanuss Berlin1s(12076) are now transferred to Sivaprakash Murugan(_123)
    Transfer Task Clean Up


*** Keywords ***

Transfer Task Clean Up
    [Documentation]
    
    Set To Dictionary    ${put_payload}    fromUserId    206
    Set To Dictionary    ${put_payload['taskList'][0]}     userId    78
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/TransferTasks    ${headers}    ${put_payload}
    RETURN    TRUE
