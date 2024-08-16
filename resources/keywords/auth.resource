*** Settings ***
Resource    ../super.resource


*** Variables ***
${AUTH_USER_NAME}    121
${AUTH_PASSWORD}    Valgen@2
#${URL}    https://testvgnext.b2clogin.com/testvgnext.onmicrosoft.com/B2C_1A_SIGNIN/oauth2/v2.0/authorize?client_id=4b3e9b35-81e1-4e8b-b8c1-b7dfc40f7d39&response_type=code&redirect_uri=https%3A%2F%2Foauth.pstmn.io%2Fv1%2Fcallback&response_mode=query&scope=https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FLoginApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FElogbookApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FComponentApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FAuditTrailApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FLocalizationApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FEntityApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FStructureApi%20https%3A%2F%2Ftestvgnext.onmicrosoft.com%2Fa6d2e540-d9a6-4141-a39f-80a00bf8727d%2FManageApi&state=12345&code_challenge=9Br-UoCzkCFZCknVEqXhRBeCrGzzslL9J6DLFYpSG2Y&code_challenge_method=S256
${token_endpoint}    https://testvgnext.b2clogin.com/testvgnext.onmicrosoft.com/B2C_1A_SIGNIN/oauth2/v2.0/token
${client_id}         4b3e9b35-81e1-4e8b-b8c1-b7dfc40f7d39
${client_secret}     p6P8Q~V5woa1knpvekfusmGtv83mtjrILYB_kbUa
#${code_verifier}     S.TSJGRhDr7Oy-kygKNk-IcAuouqK.oXKOmZ2SJqH_N
${redirect_uri}      https://oauth.pstmn.io/v1/callback
${scope}             https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/LoginApi https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/ElogbookApi https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/ComponentApi https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/AuditTrailApi https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/LocalizationApi https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/EntityApi https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/StructureApi \https://testvgnext.onmicrosoft.com/a6d2e540-d9a6-4141-a39f-80a00bf8727d/ManageApi
${code_challenge_method}    S256

*** Keywords ***
Generate OAuth Token
    ${cache_key} =    Set Variable    api-session
    ${cached_token} =    Cache Retrieve value    ${cache_key}
    IF    $cached_token is not $None
        ${auth_token}    Set Variable    ${cached_token}
        Set Global Variable    ${auth_token}       
        RETURN    ${auth_token}
    END

    ${code_verifier}=    Generate Code Verifier    43
    Set Suite Variable   ${code_verifier} 
    ${code_challenge}=    Generate Code Challenge    ${code_verifier}
    Set Suite Variable   ${code_challenge} 

    ${URL}    Set Variable    https://testvgnext.b2clogin.com/testvgnext.onmicrosoft.com/B2C_1A_SIGNIN/oauth2/v2.0/authorize?client_id=${client_id}&response_type=code&redirect_uri=${redirect_uri}&response_mode=query&scope=${scope}&code_challenge=${code_challenge}&code_challenge_method=${code_challenge_method}
    ${response_url}=    Enter login Details and Capture URL    ${URL}    ${AUTH_USER_NAME}    ${AUTH_PASSWORD}
    Wait Until Time    10

    ${code}=    Extract Code From URL    ${response_url}    
    Set Suite Variable    ${code}

    ${auth_token}=    Get Access Token    
    Cache Store Value    ${cache_key}    ${auth_token}
    Set Global Variable    ${auth_token} 
    RETURN    ${auth_token}

# Generate PKCE Code Verifier And Code Challenge
#     ${verifier}=    Generate Code Verifier    43
#     Log To Console    Code Verifier: ${verifier}
#     ${challenge}=    Generate Code Challenge    ${verifier}
#     Log To Console   Code Challenge: ${challenge}

Enter login Details and Capture URL
    [Arguments]    ${URL}    ${USER_NAME}    ${PASSWORD}
    Launch Web Application    ${BROWSER_NAME}    ${URL}
    Wait Until Time    10
    Wait Until Element Is Visible    //input[@id="signInName"]
    Input Text    //input[@id="signInName"]    ${USER_NAME}
    Wait Until Element Is Clickable And Click    //input[@id="password"]    ${LONG_WAIT}
    Javascript Input Text   //input[@id="password"]    ${PASSWORD}
    Javascript Click    //button[@id="next"]    
    ${response_url}=    Capture and Store Response URL
    [Return]    ${response_url}

Capture and Store Response URL
    Wait Until Time    10
    ${response_url}=    Get Location
    Log To Console    new:${response_url}
    Set Suite Variable    ${response_url}
    [Return]    ${response_url}

Extract Code From URL
    [Arguments]    ${response_url}
    ${query} =    Split String    ${response_url}    ?    1
    ${query_part} =    Set Variable    ${query}[1]
    ${code_param} =    Fetch From Right    ${query_part}    code=
    ${end_index} =    Evaluate    "${code_param}".find('&')
    ${final_code} =    Run Keyword If    ${end_index} != -1    Get Substring    ${code_param}    0    ${end_index}    ELSE    Set Variable    ${code_param}
    [Return]    ${final_code}

Get Access Token
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${data}=    Create Dictionary    code=${code}    client_id=${client_id}    scope=${scope}
    ...    redirect_uri=${redirect_uri}    grant_type=authorization_code    client_secret=${client_secret}
    ...    code_verifier=${code_verifier}

    ${response}=    Post    ${token_endpoint}    headers=${headers}    data=${data}

    Log    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    Set Suite Variable    ${access_token}    ${response.json()['access_token']}
    Log To Console    accessToken from keyword:${access_token}
    Log To Console    entire response:${response.content}
    [Return]    ${access_token}