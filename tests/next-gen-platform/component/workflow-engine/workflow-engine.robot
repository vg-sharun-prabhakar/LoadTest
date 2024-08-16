*** Settings ***
Resource        ../../../../resources/super.resource
Library         BuiltIn
Library         random

Suite Setup     Load Workflow Data


*** Variables ***
${userId}       9


*** Test Cases ***
Create workFlowEngine
    [Documentation]    This test case to Create workFlowEngine.
    [Tags]    tcwe01

    # Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${Create Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow json saved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update workFlowEngine
    [Documentation]    This test case to Update workFlowEngine.
    [Tags]    tcwe02

    # Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow json updated successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Accept workFlowEngine
    [Documentation]    This test case to Accept workFlowEngine.
    [Tags]    tcwe03

    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Post request
    ${response}    Put Api    ${URL}/Accept    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow accepted successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Complete workFlowEngine
    [Documentation]    This test case to Complete workFlowEngine.
    [Tags]    tcwe04

    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/Accept    ${headers}    ${Accept Payload}

    # Complete the approval request
    ${response}    Put Api    ${URL}/Complete    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow completed successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reject workFlowEngine
    [Documentation]    This test case to Complete workFlowEngine.
    [Tags]    tcwe05

    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/Accept    ${headers}    ${Accept Payload}

    # Post request
    ${response}    Put Api    ${URL}/Reject    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow rejected successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

RouteBackToAuthor workFlowEngine
    [Documentation]    This test case to RouteBackToAuthor workFlowEngine.
    [Tags]    tcwe06

    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/RouteBackToAuthor    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow routed back to author successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

TaskTransfer workFlowEngine
    [Documentation]    This test case to TaskTransfer workFlowEngine.
    [Tags]    tcwe07

    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/Accept    ${headers}    ${Accept Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/TaskTransfer    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow task transferred successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

AcceptTransferTask workFlowEngine
    [Documentation]    This test case to AcceptTransferTask workFlowEngine.
    [Tags]    tcwe08

    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/Accept    ${headers}    ${Accept Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/TaskTransfer    ${headers}    ${Accept Payload}

    # Accept the approval request
    ${response}    Put Api    ${URL}/AcceptTransferTask    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow task accepted successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Delete workFlowEngine
    [Documentation]    This test case to Delete workFlowEngine.
    [Tags]    tcwe09

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Put Api    ${URL}/Delete    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    workflow deleted successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate workFlowEngine
    [Documentation]    This test case to Terminate workFlowEngine.
    [Tags]    tcwe10

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    workflow has been terminated

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

GetWorkflowJson workFlowEngine
    [Documentation]    This test case to GetWorkflowJson workFlowEngine.
    [Tags]    tcwe11

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Get Api    ${URL}/GetWorkflowJson?component=FORM&instanceId=9999    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    WorkflowJson retrieved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

GetWorkflowDetails workFlowEngine
    [Documentation]    This test case to GetWorkflowDetails workFlowEngine.
    [Tags]    tcwe12

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Get Api    ${URL}/GetWorkflowJson?component=FORM&instanceId=9999&nodeId=0    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    WorkflowJson retrieved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

GetWorkflowComments workFlowEngine
    [Documentation]    This test case to GetWorkflowComments workFlowEngine.
    [Tags]    tcwe13

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Get Api    ${URL}/GetWorkflowComments?component=FORM&instanceId=9999    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Comments retrieved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

GetUnResolvedComments workFlowEngine
    [Documentation]    This test case to GetUnResolvedComments workFlowEngine.
    [Tags]    tcwe14

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Get Api    ${URL}/GetUnResolvedComments?component=FORM&instanceId=9999    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    No unresolved comments found

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

ResolveComment workFlowEngine
    [Documentation]    This test case to ResolveComment workFlowEngine.
    [Tags]    tcwe15

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Put Api    ${URL}/ResolveComment    ${headers}    ${Accept Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Comment has been resolved

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

GetReviewAndApprovalResults workFlowEngine
    [Documentation]    This test case to GetReviewAndApprovalResults workFlowEngine.
    [Tags]    tcwe16

    Set To Dictionary    ${Update Payload}    instanceId=${9999}
    # Route For approval request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${Update Payload}

    Set To Dictionary    ${Accept Payload}    instanceId=${9999}
    # Accept the approval request
    ${response}    Get Api    ${URL}/GetReviewAndApprovalResults?component=FORM&instanceId=9999    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Review and approval results retrieved successfully

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


*** Keywords ***
Load Workflow Data
    ${workflowData}    Load JSON From File    ${CURDIR}\\workflow-engine.json
    Set Suite Variable    ${URL}    ${workflowData['URL']}
    Set Suite Variable    ${Create Payload}    ${workflowData['CreateBody']}
    Set Suite Variable    ${Update Payload}    ${workflowData['CreateBody']}
    Set To Dictionary    ${Update Payload}    routeTo=${2}

    Set Suite Variable    ${Accept Payload}    ${workflowData['routeBody']}
