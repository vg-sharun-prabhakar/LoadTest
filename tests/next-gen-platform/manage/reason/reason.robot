*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${siteId}    0
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/manage/api/v1/Reason

*** Test Cases *** 
Creates the Reason
    [Documentation]    This test case creates the Reason.
    [Tags]    NGP-4463

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\reason\\reason.json
    ${Create_Reason}    Set Variable    ${variables["CreateReason"]}
    ${auto_generated}    Generate Random String    length=8    chars=[LETTERS]
    ${reasonName}    Set Variable    reason_${auto_generated}
    Set Suite Variable    ${reasonName}
    Set To Dictionary    ${Create_Reason}    reasonName    ${reasonName}
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${Create_Reason}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    Reason has been Created
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Reason Details Using Reason Name
    [Documentation]    This test case to get Reason details using Reason name.
    [Tags]    Filter By Name

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${reasonName}   ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['reasonName']}      ${reasonName}  

    Set Suite Variable    ${reasonId}    ${response.json()['data'][0]['reasonId']}
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get All Reason details
    [Documentation]    This test case to get All Reason details in batch.
    [Tags]    NGP-4464

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?batchNumber=1&batchSize=10&sortKey=task&sortOrder=desc&searchKey=&filterModels=[]    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    #Verify Response Field Is Not Empty    ${response}    ['data'][0]['id']           
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

View the Reason Details
    [Documentation]    This test case to View the Reason Details.
    [Tags]    View Reason

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${reasonId}    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    reasonName    ${reasonName}
 
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the Reason
    [Documentation]    This test case to Update the Reason.
    [Tags]    NGP-4465
    
    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\reason\\reason.json
    ${Update_Reason}    Set Variable    ${variables["UpdateReason"]}
    Set To Dictionary    ${Update_Reason}    reasonId    ${reasonId}
    Set To Dictionary    ${Update_Reason}    reasonName    ${reasonName}

    Set Suite Variable    ${Put Body}    ${Update_Reason}
        
    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}     ${Put Body} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${reasonName} Reason has been edited
          
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}
    
Get all the Active Reason
    [Documentation]    This test case to get all the Active Reason.
    [Tags]    Active Reasons
        
    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetActive?siteId=${siteId}    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
          
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the Reason
    [Documentation]    This test case to deactivate the Reason.
    [Tags]    NGP-4466

    ${variables}    Load JSON From File    ${JSONPATH}\\next-gen-platform\\manage\\reason\\reason.json
    ${StatusChangePayload}    Set Variable    ${variables["StatusChangePayload"]}
    Set To Dictionary    ${StatusChangePayload}    id    ${reasonId}


    Set Suite Variable    ${changeStatus_payload}    ${StatusChangePayload}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${changeStatus_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${reasonName} Reason has been deactivated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the Reason
    [Documentation]    This test case to Reactivate the Reason.
    [Tags]    NGP-4467

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${changeStatus_payload} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${reasonName} Reason has been reactivated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the Reason
    [Documentation]    This test case to Terminate the Reason.
    [Tags]    NGP-4468

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${changeStatus_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${reasonName} Reason has been terminated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}








