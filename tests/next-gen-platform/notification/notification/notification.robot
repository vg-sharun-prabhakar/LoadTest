*** Settings ***
Resource        ../../../../resources/super.resource
Library         RequestsLibrary
Library         OperatingSystem
Library         Collections
Library         BuiltIn
Library         random

Suite Setup     Load Notification Data


*** Variables ***
${userId}       9


*** Test Cases ***
Send Notification Mail
    [Documentation]    This test case to Post in Notification.
    [Tags]    tcn01

    # Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/POST    ${headers}    ${Post Payload}

    # Verification/Assertions
    Verify Response Code    ${response.status_code}    200

    # To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


*** Keywords ***
Load Notification Data
    ${notificationData}    Load JSON From File    ${CURDIR}\\notification.json
    Set Suite Variable    ${URL}    ${notificationData['URL']}
    Set Suite Variable    ${Post Payload}    ${notificationData['PostBody']}
