*** Settings ***
Resource    ../../../../resources/super.resource

*** Variables ***
${uniqueUserId}  robot90  #sharun1
${firstName}    robot88     #Sharun1
${lastName}     user1   #Shetty
${groupTypeId}    1
${email}
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/manage/api/v1/User
${Post Body}   {"uniqueUserId": "${uniqueUserId}","firstName": "${firstName}","lastName": "${lastName}","email": "robot2@valgenesis.com","roleId": 266,"roleText": "Robot6","siteId": 308,"departmentId": 14,"departmentText": "Engineering","jobTitleId": 2,"jobTitleText": "Test Engineer","permissions": [],"userTypeId": 1,"userTypeText": "Internal","userProfileUrl": ""}
${update Body}    {"userId":238,"uniqueUserId":"${uniqueUserId}","firstName":"${firstName}","lastName":"${lastName}","email":"sharun1@valgenesis.com","roleId":195,"roleText":"Robot14","userTypeId":1,"userTypeText":"Internal","userName":"Sharun1 Shetty","comments":"test automation","permissions":null,"userProfileUrl":"","siteId":308,"siteText":"DefaultSite","departmentId":14,"departmentText":"Engineering","jobTitleId":13,"jobTitleText":"Asc Engg"}
${Deactivate_payload}    {"id":394,"comments":"test automation","esignReason":""}
${user_profile}    {"userId": 46, "address": null, "email": "SathishKumar.Dhanapalan@valgenesis.com", "phoneNumber": null, "countryCodeId": null, "timeZoneId": 1, "defaultLandingId": null, "userSiteMapDto": [{"userId": 46, "siteId": null, "preferLanguageId": null}], "userProfileUrl": "https://stngptest.blob.core.windows.net/ngp-components/fileUpload/valgenesis/UserProfileImage/UserProfile/41f02aac-b8f9-4fe8-b70b-964ea3d5f539.jpeg", "originalUserProfileUrl": "https://stngptest.blob.core.windows.net/ngp-components/fileUpload/valgenesis/UserProfileImage/UserProfile/f2fce2cc-148e-4238-a9d1-0904b3476c7c.png", "profileCroppedArea": {"x": 90, "y": 90, "width": 180, "height": 180}}
${Invite_payload}    {"Id": "44","comments":"test automation","esignReason":""}
#${reinvite_payload}    {"Id":236,"comments":"test automation.\n","esignReason":""}

*** Test Cases ***
Send Invitation to the User
    [Documentation]    This test case send the invite link.
    [Tags]    TCU01
    ${random_string}   Generate Random String    10
    ${random_string}    Convert To Lowercase     ${random_string}
    ${post_payload}=    Evaluate    json.loads("""${Post Body}""")    json
    Set To Dictionary    ${post_payload}    email    ${random_string}@valgenesis.com
    Set To Dictionary    ${post_payload}    uniqueUserId    ${uniqueUserId}${random_string}

    Set Suite Variable    ${invited_user_UId}    ${uniqueUserId}${random_string}

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/SendInvitation    ${headers}    ${post_payload}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${uniqueUserId}${random_string}-${firstName} ${lastName} has been invited
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}
    
Get Batch Users details to Get the perticular User Id
    [Documentation]    This test case to get Batch Users details to Get the perticular User Id.
    [Tags]    TCU08

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?searchKey=${invited_user_UId}    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['data'][0]['uniqueUserId']}      ${invited_user_UId}  

    Set Suite Variable    ${invited_userId}    ${response.json()['data'][0]['userId']}
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the User
    [Documentation]    This test case to update the user.
    [Tags]    TCU02

    ${put_payload}=    Evaluate    json.loads("""${update Body}""")    json
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update    ${headers}    ${put_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    ${uniqueUserId}-${firstName} ${lastName} has been edited
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the User
    [Documentation]    This test case to deactivate the user.
    [Tags]    TCU03

    ${put_payload}=    Evaluate    json.loads("""${Deactivate_payload}""")    json
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${put_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    1340-berlin1 Test has been deactivated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Reactivate the User
    [Documentation]    This test case to reactivate the user.
    [Tags]    TCU04
    ${put_payload}=    Evaluate    json.loads("""${Deactivate_payload}""")    json
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Reactivate    ${headers}    ${put_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    1340-berlin1 Test has been reactivated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the User
    [Documentation]    This test case to termiante the user.
    [Tags]    TCU05
        
    ${Terminate_payload}=    Evaluate    json.loads("""{"Id":${invited_userId},"comments":"test automation","esignReason":""}""")    json
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${Terminate_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Log To Console    Response JSON: ${response.content}
   Verify Response String    ${response.content}    ${invited_user_UId}-${firstName} ${lastName} has been terminated
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get Batch Users details
    [Documentation]    This test case to get user details in batch.
    [Tags]    TCU06

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?BatchNumber=1&BatchSize=10&sortKey=uniqueUserId&sortOrder=asc&searchKey=&filterModels=[]    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200     
    Length Should Be    ${response.json()['data']}    10
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get the User Detail.
    [Documentation]    This test case to get user getails in batch.
    [Tags]    TCU07

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=239    ${headers}    ${Deactivate_payload}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['userId']}     239         
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


Get all the Active Users
    [Documentation]    This test case to get all the Active Users.
    [Tags]    TCU09

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetActive    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get all the Active Users based on the Group Type.
    [Documentation]    This test case to get all the Active Users based on the Group Type.
    [Tags]    TCU10

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetActiveUserByGroupType?groupTypeId=${groupTypeId}    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get all the Active Users by Site.
    [Documentation]    This test case to get all the Active Users by Site.
    [Tags]    TCU11

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetUserBySite    ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}
    
Get the User Sites
    [Documentation]    This test case to get the User Sites.
    [Tags]    TCU12

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetUserSite?id=1   ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get System Values
    [Documentation]    To get the system values
    [Tags]    TCR08
    ${column}    Set Variable    name
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetSystemValues?column=${column}    ${headers}
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()[0]['value']}      name

Get the User Detail by List of Ids.
    [Documentation]    This test case to get user getails in batch.
    [Tags]    TCU07
     ${json_body}=    Create List    ${70}
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/GetUsersByIds    ${headers}   ${json_body}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()[0]['userId']}     70
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

UnInvite the User
    [Documentation]    This test case to UnInvite the User.
    [Tags]    TCU13
    ${put_payload}=    Evaluate    json.loads("""${Invite_payload}""")    json    
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/RevokeInvite   ${headers}    ${put_payload}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    demo-demo test has been uninvited
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Invite the UnInvited User
    [Documentation]    This test case to Invite the UnInvited User.
    [Tags]    TCU15
    ${put_payload}=    Evaluate    json.loads("""${Invite_payload}""")    json
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Invite   ${headers}    ${put_payload}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response String    ${response.content}    demo-demo test has been invited
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}



Update the User profile
    [Documentation]    This test case to Update the User profile.
    [Tags]    TCU16

    ${put_payload}=    Evaluate    json.loads("""${user_profile}""")    json    
    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/UpdateProfile   ${headers}    ${put_payload}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    #Verify Response Field    ${response}    name    Apple MacBook Pro 16
    Verify Response String    ${response.content}    Changes in Profile is saved successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}
    

















    







