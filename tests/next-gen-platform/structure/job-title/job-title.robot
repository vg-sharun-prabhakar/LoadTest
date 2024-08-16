*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/structure/api/v1/JobTitle
${JSONFILEPATH}    ${EXECDIR}\\tests\\next-gen-platform\\structure\\job-title\\jobtitle-mock-data.json

*** Test Cases ***

Create a JobTitle
    [Documentation]    This tests job title creation with valid payload.
    [Tags]    TCD01PostJobTitleTag

    # this line hides the sensitive data to be logged
    Set Log Level    WARN

    ${jsonData}    Load Json From File    ${JSONFILEPATH}
    Set Suite Variable    ${JOBTITLEDATA}    ${jsonData}

    ${postPayload}    Set Variable    ${JOBTITLEDATA['postBody']}
    ${randomStr}    Generate Random String    20    abcdefghijklmnopqstuvqxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
    Set To Dictionary    ${postPayload}    jobTitleName    ${randomStr}
    Log To Console    ${postPayload}
    Set Suite Variable    ${JOBTITLE_NAME}    ${randomStr}

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create    ${headers}    ${postPayload}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${JOBTITLE_NAME} has been created

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get All JobTitle details
    [Documentation]    This test to get all JobTitle details.
    [Tags]    TCJT02

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?BatchNumber=1&BatchSize=10&sortKey=jobTitleNumber&sortOrder=asc&searchKey=&filterModels=[]    ${headers}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    #Verify Response String    ${response.content}    ${JOBTITLE_NAME} has been created

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get JobTitle details using job title name
    [Documentation]    This test to get all JobTitle details.
    [Tags]    TCJT02

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${JOBTITLE_NAME}    ${headers}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['jobTitleName']}      ${JOBTITLE_NAME}

    Set Suite Variable    ${JOBTITLE_ID}    ${response.json()['data'][0]['jobTitleId']}

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the JobTitle
    [Documentation]    This test to Update the JobTitle.
    [Tags]    TCJT06


    ${putPayload}    Set Variable    ${JOBTITLEDATA['putBody']}
    Set To Dictionary    ${putPayload}    jobTitleId    ${JOBTITLE_ID}
    Set To Dictionary    ${putPayload}    jobTitleName    ${JOBTITLE_NAME}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${putPayload}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${JOBTITLE_NAME} has been edited

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


Deactivate the JobTitle.
    [Documentation]    This test to Deactivate the JobTitle.
    [Tags]    TCJT03

    ${changeStatusVariable}    Set Variable    ${JOBTITLEDATA['changeStatusBody']}
    Set To Dictionary    ${changeStatusVariable}    id    ${JOBTITLE_ID}
    Set Suite Variable    ${changeStatusPayload}    ${changeStatusVariable}

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${changeStatusPayload}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${JOBTITLE_NAME} has been deactivated

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the JobTitle.
    [Documentation]    This test to Reactivate the JobTitle..
    [Tags]    TCJT04

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${changeStatusPayload}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${JOBTITLE_NAME} has been reactivated

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the JobTitle.
    [Documentation]    This test to Terminate the JobTitle..
    [Tags]    TCJT05

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${changeStatusPayload}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${JOBTITLE_NAME} has been terminated

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

View the JobTitle Detail
    [Documentation]    This test to View the JobTitle Detail.
    [Tags]    TCJT07

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${JOBTITLE_ID}    ${headers}

    #Verification/Assertions
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    jobTitleName    ${JOBTITLE_NAME}

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.json()}