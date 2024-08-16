*** Settings ***
Resource    ../super.resource
Library     ../../library/CustomLibrary.py
Library     ../../library/JSONManipulation.py


*** Keywords ***
# Post Api
#    [Arguments]    ${url}    ${headers}    ${json_body}
#    ${body_dictionary}    Parse Json To Dictionary    ${json_body}
#    ${response}    POST    ${url}    json=${body_dictionary}    headers=${headers}
#    [Return]    ${response}

Post Api
    [Arguments]    ${url}    ${headers}    ${json_body}
    ${response}    POST    ${url}    json=${json_body}    headers=${headers}
    RETURN    ${response}

Post Api without Json Body
    [Arguments]    ${url}    ${headers}
    ${response}    POST    ${url}    headers=${headers}
    RETURN    ${response}

Put Api
    [Arguments]    ${url}    ${headers}    ${json_body}
    ${response}    PUT    ${url}    json=${json_body}    headers=${headers}
    RETURN    ${response}

Get Api
    [Documentation]    Send the Get Api call, with or without JSON body
    [Arguments]    ${url}    ${headers}    ${data}=null    ${json_body}=null
    ${body_dictionary}    Parse Json To Dictionary    ${json_body}
    ${parameter_object}    Parse Json To Dictionary    ${data}
    ${response}    GET    ${url}    params=${parameter_object}    json=${body_dictionary}    headers=${headers}
    RETURN    ${response}

Verify Response Code
    [Documentation]    This keyword is to verify whether the response code is 200
    [Arguments]    ${actual_response_code}    ${expected_response_code}
    Should Be Equal As Integers    ${actual_response_code}    ${expected_response_code}

Verify Response Field
    [Documentation]    This keyword is to verify whether the response variable in the JSON first level is equal to the expected_value
    [Arguments]    ${response}    ${key}    ${expected_value}
    ${actual_value}    Evaluate    ${response.json()}.get("${key}", None)
    Should Be Equal As Strings    ${actual_value}    ${expected_value}

Verify Response Field Is Not Empty
    [Documentation]    This keyword is to verify whether the response variable is not empty
    [Arguments]    ${response}    ${key}
    ${actual_value}    Evaluate    ${response.json()}.get("${key}", None)
    Should Not Be Empty    ${actual_value}

Verify Response String
    [Documentation]    This keyword
    [Arguments]    ${response_message}    ${expected_message}
    ${response_content}    Convert To String    ${response_message}
    ${status}    Run Keyword And Return Status    Should Contain    ${response_content}    ${expected_message}
    IF    '${status}'=='False'    Fail    status failed

Extract value from Json Array of Objects
    [Documentation]    This keyword Extracts value from Json Array of Objects and stores values in array.
    [Arguments]    ${response_message}    ${array_name}    ${variable_name}
    ${expected_array}    Extract Json Value To Array    ${response_message}    ${array_name}    ${variable_name}
    RETURN    ${expected_array}

Delete record from DB
    [Documentation]    This keyword is to delete record in DB.
    [Arguments]    ${column_name}    ${column_value}

    # Connect to the database
    Connect To Database    psycopg2    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

    ${query_result_after_delete}    Execute Sql String    DELETE FROM users WHERE ${column_name}='${column_value}'

    # Log the response to console (optional)
    Log To Console    Response: ${query_result_after_delete}    # Might be empty after DELETE

    # Disconnect from the database
    Disconnect From Database

Execute SQL Commands
    [Documentation]    Connect to the PostgreSQL database, execute a query, and validate results.
    [Arguments]    ${variable}    ${value}

    # Connect to the database (assuming psycopg2 library is imported)
    Connect To Database    psycopg2    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

    ${Query_Statement}    set Variable    DELETE FROM users WHERE ${variable}='${value}'

    # Execute the deletion query
    ${query_result_after_delete}    Execute Sql String    ${Query_Statement}

    # Log the response to console (optional)
    Log To Console    Response: ${query_result_after_delete}    # Might be empty after DELETE

    # Disconnect from the database
    Disconnect From Database

Capture Request
    [Arguments]    ${request}
    ${REQUEST_LOGS}    set variable    []
    Append To List    ${REQUEST_LOGS}    ${request.url}
