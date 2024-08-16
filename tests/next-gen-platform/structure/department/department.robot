*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/structure/api/v1/Department
${JSONFILEPATH}    ${EXECDIR}\\tests\\next-gen-platform\\structure\\department\\department-mock-data.json

*** Test Cases ***

Create a Department
    [Documentation]    This tests department creation with valid payload.
    [Tags]    TCD01PostDepartmentTag

    # this line hides the sensitive data to be logged
    Set Log Level    WARN

    ${jsonData}    Load Json From File    ${JSONFILEPATH}
    Set Suite Variable    ${DEPARTMENTDATA}    ${jsonData}

    ${postPayload}    Set Variable    ${DEPARTMENTDATA['postBody']}
    ${randomStr}    Generate Random String    20    abcdefghijklmnopqstuvqxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
    Set To Dictionary    ${postPayload}    departmentName    ${randomStr}
    Log To Console    ${postPayload}
    Set Suite Variable    ${DEPARTMENTNAME}    ${randomStr}

    # Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${postPayload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${DEPARTMENTNAME} has been created

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Department Details Using Department Name
    [Documentation]    This test case to get Department details using department name.
    [Tags]    TCD02

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${DEPARTMENTNAME}   ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['departmentName']}      ${DEPARTMENTNAME}

    Set Suite Variable    ${DEPARTMENTID}    ${response.json()['data'][0]['departmentId']}

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

View the Department Details
    [Documentation]    This test case to View the Department Details.
    [Tags]    TCD05

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${DEPARTMENTID}    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    departmentName    ${DEPARTMENTNAME}

    Set Suite Variable    ${DEPARTMENTNUMBER}    ${response.json()['departmentNumber']}

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get All Departments details
    [Documentation]    This test case to get All Departments details in batch.
    [Tags]    TCD02

    # Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?batchNumber=1&batchSize=10&sortKey=task&sortOrder=desc&searchKey=&filterModels=[]    ${headers}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    # Verify Response Field Is Not Empty    ${response}    ['data'][0]['id']

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the Department
    [Documentation]    This test case to Update the Department.
    [Tags]    TCD04

    ${putPayload}    Set Variable    ${DEPARTMENTDATA['putBody']}
    Set To Dictionary    ${putPayload}    departmentId    ${DEPARTMENTID}
    Set To Dictionary    ${putPayload}    departmentName    ${DEPARTMENTNAME}
    Set To Dictionary    ${putPayload}    departmentNumber    ${DEPARTMENTNUMBER}

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}     ${putPayload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${DEPARTMENTNAME} has been edited

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the Department
    [Documentation]    This test case to deactivate the department.
    [Tags]    TCD06

    ${changeStatusVariable}    Set Variable    ${DEPARTMENTDATA['changeStatusBody']}
    Set To Dictionary    ${changeStatusVariable}    id    ${DEPARTMENTID}
    Set Suite Variable    ${changeStatusPayload}    ${changeStatusVariable}

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${changeStatusPayload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${DEPARTMENTNUMBER}-${DEPARTMENTNAME} has been deactivated

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the Department
    [Documentation]    This test case to Reactivate the department.
    [Tags]    TCD07

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${changeStatusPayload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${DEPARTMENTNUMBER}-${DEPARTMENTNAME} has been reactivated

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the Department
    [Documentation]    This test case to Terminate the department.
    [Tags]    TCD08

    # Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${changeStatusPayload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${DEPARTMENTNUMBER}-${DEPARTMENTNAME} has been terminated

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

