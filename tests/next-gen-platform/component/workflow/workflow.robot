*** Settings ***
Resource        ../../../../resources/super.resource
Library         RequestsLibrary
Library         OperatingSystem
Library         Collections
Library         BuiltIn
Library         random

Suite Setup     Load Workflow Data


*** Variables ***
${userId}       9


*** Test Cases ***
Get all the workflow
    [Documentation]    This test case to Get all the workflow.
    [Tags]    tcwf01

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetWorkflow    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflows retrieved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get All Workflow details in batch
    [Documentation]    This test case to get All Workflow details in batch.
    [Tags]    tcwf02

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api
    ...    ${URL}/GetBatch?batchNumber=1&batchSize=10&sortKey=uniqueId&sortOrder=asc&searchKey=&filterModels=[]
    ...    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Test case to Generate UniqueId
    [Documentation]    This Test case to Generate UniqueId.
    [Tags]    tcwf03

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GenerateUniqueId    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200

    Set Suite Variable    ${uniqueId}    ${response.content}

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Is User Visited HelpCard
    [Documentation]    This test case check User Visited HelpCard.
    [Tags]    tcwf04

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/IsUserVisitedHelpCard?userId=${userId}    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update User HelpCard Visitors
    [Documentation]    This test case checks if the user visited the help card.
    [Tags]    tcwf05

    # Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api without Json Body    ${URL}/UpdateHelpCardVisitors?userId=${userId}    headers=${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow helpcard visitor updated successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Module List
    [Documentation]    This test case to get Get Module List.
    [Tags]    tcwf06

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetModuleList    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Module list retrieved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Validate Workflow
    [Documentation]    This test case to Validate Workflow.
    [Tags]    tcwf07

    # Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/ValidateWorkflow    ${headers}    ${postBody}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow validated successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Create Workflow
    [Documentation]    This test case to Create Workflow.
    [Tags]    tcwf08

    # Create Workflow
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${Post Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow created successfully

    # Deleted the created Workflow
    ${workflowId}    Set Variable    ${response.json()['data']['workflowId']}
    Set To Dictionary    ${Put Body}    Id=${workflowId}
    ${response}    Put Api    ${URL}/Delete    ${headers}    ${Put Body}

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the workflow
    [Documentation]    This test case to Update the workflow.
    [Tags]    tcwf09

    # Create Workflow
    ${Put Body}    Create Workflow

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Put Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow updated successfully

    # Deleted the created Workflow
    Delete Workflow

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the Workflow
    [Documentation]    This test case to deactivate the Workflow.
    [Tags]    tcwf10

    # Create Workflow
    ${Put Body}    Create Workflow

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${Put Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow deactivated successfully

    # Deleted the created Workflow
    Delete Workflow

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the Workflow
    [Documentation]    This test case to Reactivate the Workflow.
    [Tags]    tcwf11

    # Create Workflow
    ${Put Body}    Create Workflow

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${Put Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow reactivated successfully

    # Deleted the created Workflow
    Delete Workflow

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the Workflow
    [Documentation]    This test case to Terminate the Workflow.
    [Tags]    tcwf12

    # Create Workflow
    ${Put Body}    Create Workflow

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${Put Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow terminated successfully

    # Deleted the created Workflow
    Delete Workflow

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Delete the Workflow
    [Documentation]    This test case to Delete the Workflow.
    [Tags]    tcwf13

    # Create workflow
    ${Put Body}    Create Workflow

    # Put request to delete workflow
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Delete    ${headers}    ${Put Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow deleted successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Revise the Workflow
    [Documentation]    This test case to Revise the Workflow.
    [Tags]    tcwf14

    # Create workflow
    ${Post Body}    Create Workflow
    ${random_number}    Evaluate    random.randint(1000, 9999)    random
    ${workflow_name}    Set Variable    Robot${random_number}
    Log To Console    Response JSON: Robot${random_number}
    Set To Dictionary    ${Post Body}    workflowName=${workflow_name}
    ${random_number}    Evaluate    random.randint(1, 100)    random
    Set To Dictionary    ${Post Body}    uniqueId="DS1_WF_0128."${random_number}

    # Put request to delete workflow
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Revise    ${headers}    ${Post Body}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow revised successfully

    # Deleted the created Workflow
    Delete Workflow

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


*** Keywords ***
Load Workflow Data
    ${workflowData}    Load JSON From File    ${CURDIR}\\workflow.json
    Set Suite Variable    ${URL}    ${workflowData['URL']}
    Set Suite Variable    ${Post Body}    ${workflowData['PostBody']}
    Set Suite Variable    ${Put Body}    ${workflowData['PostBody']}

    # Generate a random number
    ${random_number}    Evaluate    random.randint(1000, 9999)    random

    # Update the workflowName with the random number
    ${workflow_name}    Set Variable    Robot${random_number}
    Log To Console    Response JSON: Robot${random_number}
    Set To Dictionary    ${Post Body}    workflowName=${workflow_name}

Create Workflow
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${Post Body}
    ${workflowId}    Set Variable    ${response.json()['data']['workflowId']}
    Set To Dictionary    ${Put Body}    Id=${workflowId}
    Set To Dictionary    ${Put Body}    workflowId=${workflowId}
    RETURN    ${Put Body}

Delete Workflow
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Delete    ${headers}    ${Put Body}
    RETURN    ${response}
