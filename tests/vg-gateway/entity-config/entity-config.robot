*** Settings ***
Resource    ../../../resources/super.resource

*** Variables ***
${request_id}
${GetTagIds}    ${GATEWAY_BASE_URL}/v1/entity-configs-template/get_tag_ids
${PostTagids}    ${GATEWAY_BASE_URL}/v1/entity-configs-template/post_tag_ids
${GetExistingTags}    ${GATEWAY_BASE_URL}/v1/entity-configs-template/get_existing_tags?siteid=1&limit=10&offset=0&filterModels=[]
${GetCheckTags}    ${GATEWAY_BASE_URL}/v1/entity-configs-template/check_tags

*** Test Cases ***



#TagID Upload API

PostTagids
    [Documentation]    This test create new draft tagids
    [Tags]    RND-2468    Fast

    ${variables}    Load JSON From File   tests/vg-gateway/entity-config/entity-config.json
    ${postBody}    Set Variable    ${variables['post_tagids']}
    
    #Post request   
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${PostTagids}    ${headers}    ${postBody}
    Verify Response Code    ${response.status_code}    200
    set Suite variable    ${request_id}   ${response.json()}
    Log To Console    Response JSON: ${request_id}


GetTagIds
    [Documentation]    This test get draft tagids
    [Tags]    RND-2468    Fast

    #Get request
    Log To Console    Response JSON: ${request_id['data']['request_id']}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${GetTagIds}    ${headers}  {"requestid": "${request_id['data']['request_id']}"}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200
    
GetCheckTags
    [Documentation]    Check Tags for request id
    [Tags]    RND-2468    Fast

    #Get request
    Log To Console    Response JSON: ${request_id['data']['request_id']}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${GetCheckTags}    ${headers}    {"requestid": "${request_id['data']['request_id']}"}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200

GetExistingTagIds
    [Documentation]    This test get Existing tagids
    [Tags]    RND-2468    Fast

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${GetExistingTags}    ${headers}
    
    #Assertions
    Verify Response Code    ${response.status_code}    200