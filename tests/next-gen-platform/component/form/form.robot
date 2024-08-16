*** Settings ***
Resource    ../../../../resources/super.resource
*** Variables ***

${VARIABLE_FILE}  form_variables.json
${formType}    2
${formName}    robotForm3
${userId}    286  #userId_text
${formId}    169
${nodeId}    664
${URL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/components/form/api/v1/Form
${WorkflowURL}    https://dev-vgnext-apimgmt.azure-api.net/next/test/components/workflow/api/v1/WorkflowEngine

*** Test Cases *** 
Get Parent Types
    [Documentation]    This test case to Get Parent Types.
    [Tags]    TCC01


    # Access variables from JSON
    ${formType}    Set Variable    ${formType}
    ${formName}    Set Variable    ${formName}
    ${userId}    Set Variable    ${userId}
    ${formId}    Set Variable    ${formId}
    ${nodeId}    Set Variable    ${nodeId}
    ${URL}    Set Variable    ${URL}

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetParentTypes    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Parent types retrieved successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Retrieves all applicable types.
    [Documentation]    This test case to Retrieves all applicable types.
    [Tags]    TCC02

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetApplicableTo    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    ApplicableTo retrieved successfully.
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Controller responsible for generating uniqueId.
    [Documentation]    This test responsible for generating uniqueId.
    [Tags]    TCC02

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GenerateUniqueId/${formType}   ${headers}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    ${decodedUniqueId}=    Decode Bytes To String    ${response.content}    utf-8

    Set Suite Variable    ${uniqueId}    ${decodedUniqueId}
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Validate a Form.
    [Documentation]    This test case for Validate a Form.
    [Tags]    TCC02
    ${validateFormBody}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    Set To Dictionary    ${validateFormBody}    uniqueId    ${uniqueId}
    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/ValidateForm   ${headers}    ${validateFormBody['formJson']} 
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form validated successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Create a Form.
    [Documentation]    This test case to Create a Form.
    [Tags]    TCC02
    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    
    # Generate a form name
    ${uniqueFormName}=    Generate Random String    10    [LETTERS]
    Set Suite Variable    ${formName}    robotForm_${uniqueFormName}
    ${createForm}    Set Variable    ${formJson["createForm"]}
    Set To Dictionary    ${createForm}    uniqueId    ${uniqueId}
    Set To Dictionary    ${createForm}    formName    ${formName}

    #Post request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Post Api    ${URL}/Create   ${headers}    ${createForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form created successfully

    Set Suite Variable    ${newFormId}    ${response.json()['data']['formId']}

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update the Form Status.
    [Documentation]    This test case to Update the Form Status.
    [Tags]    TCC02
    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${updateForm}    Set Variable    ${formJson["updateForm"]}
    Set To Dictionary    ${updateForm}    uniqueId    ${uniqueId}
    Set To Dictionary    ${updateForm}    formId    ${newFormId}
    Set To Dictionary    ${updateForm}    formName    ${formName}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Update   ${headers}    ${updateForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form updated successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Save a Form
    [Documentation]    This test case to Save a Form.
    [Tags]    TCC02
    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${saveForm}    Set Variable    ${formJson["updateForm"]}
    Set To Dictionary    ${saveForm}    uniqueId    ${uniqueId}
    Set To Dictionary    ${saveForm}    formId    ${newFormId}
    Set To Dictionary    ${saveForm}    formName    ${formName}
   
    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Save   ${headers}    ${saveForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form saved successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Complete WorkflowEngine
    [Documentation]    This test case to Create WorkflowEngine.
    [Tags]    TCWE05
    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${createForm}    Set Variable    ${formJson["cwCreateForm"]}
    ${updateWorkflow}    Set Variable    ${formJson["updateWorkflow"]}
    ${acceptForm}    Set Variable    ${formJson["acceptForm"]}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GenerateUniqueId/${formType}   ${headers}
    ${decodedUniqueId}    Decode Bytes To String    ${response.content}    utf-8
    ${uniqueId}    Set Variable    ${decodedUniqueId}
    ${uniqueFormName}    Generate Random String    10    [LETTERS]
    Set Suite Variable    ${formName}    robotForm_${uniqueFormName}
    ${workflowId}    Set Variable    190

    Set To Dictionary    ${createForm}    uniqueId    ${uniqueId}
    Set To Dictionary    ${createForm['workflow']}    workflowId    ${workflowId}
    Set To Dictionary    ${createForm}    formName    ${formName}
    Set To Dictionary    ${createForm}    workflowId    ${workflowId}


    ${response}    Post Api    ${URL}/Create   ${headers}    ${createForm}
    ${formId}    Set Variable   ${response.json()['data']['formId']}
    Set To Dictionary    ${updateWorkflow}    instanceId    ${formId}
    Set To Dictionary    ${updateWorkflow}    workflowId    ${workflowId}
    Set To Dictionary    ${updateWorkflow['emailMetadata']}    ComponentName    ${formName}
    Set To Dictionary    ${updateWorkflow['emailMetadata']}    ComponentUniqueId    ${uniqueId}

    ${response}    Put Api    ${WorkflowURL}/Update    ${headers}    ${updateWorkflow}

    ${nodeId}    Set Variable    ${response.json()['data']['entityWorkflowUsers'][0]['nodeId']}

    ${response}    Post Api    ${URL}/CreateWorkflowUsers   ${headers}   ${response.json()['data']}
    

    Set To Dictionary    ${acceptForm}    instanceId    ${formId}
    Set To Dictionary    ${acceptForm}    nodeId    ${nodeId}
    Set To Dictionary    ${acceptForm}    successMsg    ${uniqueId}-${formName}

    Set To Dictionary    ${acceptForm['emailMetadata']}    ComponentName    ${formName}
    Set To Dictionary    ${acceptForm['emailMetadata']}    ComponentUniqueId    ${uniqueId}

    ${response}    Put Api    ${WorkflowURL}/Accept    ${headers}    ${acceptForm}
    Verify Response Code    ${response.status_code}    200

    #Put request
    ${response}    Put Api    ${WorkflowURL}/Complete    ${headers}    ${acceptForm}
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow completed successfully

    ${response}    Post Api    ${URL}/CreateWorkflowUsers   ${headers}   ${response.json()['data']}
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Workflow users saved successfully

Get Form Name
    [Documentation]    This test case to View Form Details using Id and NodeId as params.
    [Tags]    TCWE04
    
    ${formData}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${viewFormId}    Set Variable    ${newFormId}

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetFormName?id=${viewFormId}    ${headers}

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form retrieved successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Get form in batch
    [Documentation]    This test case to Get form in batch.
    [Tags]    TCC02

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetBatch?batchNumber=1&batchSize=10&sortKey=uniqueId&sortOrder=asc&searchKey=robot&filterModels=[]   ${headers}

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Batch of forms retrieved successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}


Get all Active Forms.
    [Documentation]    This test case to Get all Active Forms.
    [Tags]    TCC02
    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${form_forSpecificBusinessStructure}    Set Variable   ${formJson['getAllActiveForm']['form_forSpecificBusinessStructure']}
    ${form_formType}    Set Variable    ${formJson['getAllActiveForm']['form_formType']}
    ${form_applicableTo}    Set Variable   ${formJson['getAllActiveForm']['form_applicableTo']}

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetActive?id=${newFormId}&forSpecificBusinessStructure=${form_forSpecificBusinessStructure}&formType=${form_formType}&applicableTo=${form_applicableTo}   ${headers}

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Active forms retrieved successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}
    

Get SystemValues
    [Documentation]    This test case to SystemValues
    [Tags]    TCWE04

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GetSystemValues    ${headers}

    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    System values retrieved successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Update a Json Form
    [Documentation]    This test case to Update a Json Form.
    [Tags]    TCWE04


    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${createForm}    Set Variable    ${formJson["createForm"]}
    ${updateForm}    Set Variable    ${formJson["updateForm"]}

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GenerateUniqueId/${formType}   ${headers}
    
    ${decodedUniqueId}    Decode Bytes To String    ${response.content}    utf-8

    ${uniqueFormName}    Generate Random String    10    [LETTERS]
    ${formName}    Set Variable    robotForm_${uniqueFormName}
    Set To Dictionary    ${createForm}    uniqueId    ${decodedUniqueId}
    Set To Dictionary    ${createForm}    formName    ${formName}
    

    #Post request
    ${response}    Post Api    ${URL}/Create   ${headers}    ${createForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form created successfully

    ${newFormId}=    Set Variable   ${response.json()['data']['formId']}
    Set To Dictionary    ${updateForm}    uniqueId    ${decodedUniqueId}
    Set To Dictionary    ${updateForm}    formId    ${newFormId}
    Set To Dictionary    ${updateForm}    formName    ${formName}


    #Put request
    ${response}    Put Api    ${URL}/UpdateJsonForm    ${headers}    ${updateForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form auto-save updated successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

View Form Details.
    [Documentation]    This test case to View Form Details using Id and NodeId as params.
    [Tags]    TCWE04

    #Get request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/Get?id=${newFormId}&nodeId=${nodeId}    ${headers}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form retrieved successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Deactivate the Form
    [Documentation]    This test case to Deactivate the Form.
    [Tags]    TCD08

    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${deactivateForm}    Set Variable    ${formJson["deactivateForm"]}
    Set To Dictionary    ${deactivateForm}    Id    ${newFormId}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Deactivate    ${headers}    ${deactivateForm}  
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form deactivated successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Terminate the WIP,Reviewed,under Review Form
    [Documentation]    This test case to Terminate the Form.
    [Tags]    TCD08

    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${terminateForm}    Set Variable    ${formJson["deactivateForm"]}
    Set To Dictionary    ${terminateForm}    Id    ${newFormId}

    #Put request
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Put Api    ${URL}/Terminate    ${headers}    ${terminateForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form terminated successfully
    
    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}

Delete a Form
    [Documentation]    This test case to Save a Form.
    [Tags]    TCC02
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${auth_token}
    ${response}    Get Api    ${URL}/GenerateUniqueId/${formType}   ${headers}
    ${uniqueId}    Decode Bytes To String    ${response.content}    utf-8

    ${formJson}    Load JSON From File    ${JSONPATH}//next-gen-platform//component//form//form.json
    ${draftForm}    Set Variable    ${formJson["draftForm"]}
    ${deleteForm}    Set Variable    ${formJson["deactivateForm"]}

    # Generate a form name
    ${uniqueFormName}    Generate Random String    10    [LETTERS]
    Set Suite Variable    ${formName}    robotForm_${uniqueFormName}
    Set To Dictionary    ${draftForm}    uniqueId    ${uniqueId}
    Set To Dictionary    ${draftForm}    formName    ${formName}

    #Post request
    ${response}    Post Api    ${URL}/Create   ${headers}    ${draftForm}
    
    #Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form created successfully

    ${newFormId}    Set Variable   ${response.json()['data']['formId']}
    ${deletePayload}    Set Variable  {"Id": ${newFormId}, "comments": "robot comment", "esignReason": "test automation"}
    ${payload}    Evaluate    json.loads("""${deletePayload}""")    json

    # PUT request to delete the form
    ${response}    Put Api    ${URL}/Delete    ${headers}    ${payload}

    # Verification/Assertions 
    Verify Response Code    ${response.status_code}    200
    Verify Response Field    ${response}    message    Form deleted successfully

    #To view the response in Console, during development
    Log To Console    Response JSON: ${response.content}










    



    












    


