*** Settings ***
Resource    ../../resources/super.resource

*** Test Cases ***
Test Case to generate OAuth Token
    [Documentation]    TestCase to generate oauth token. This is the prerequisite.

    #this line hides the sensitive data from logging
    Set Log Level    WARN 

    ${auth_token}    Generate OAuth Token

    

    Log To Console    The Auth Token is: ${auth_token}
    
