*** Settings ***
Documentation    Contains generic keywords that can be used in all test cases
Library    ../../library/CustomLibrary.py
Resource    ../super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Launch Web Application
    [Arguments]    ${browser_name}    ${url}
    [Documentation]    Launch the browser and application depending on the arguments we pass
    ${session}    Run Keyword And Return Status    SeleniumLibrary.Get Session Id
    IF    '${session}'=='True'
        SeleniumLibrary.Delete All Cookies
        SeleniumLibrary.Go To    ${url}
    ELSE
        Launch Browser    ${browser_name}    ${url}
    END
    SeleniumLibrary.Maximize Browser Window
    RETURN    ${session}

Launch Browser
    [Arguments]    ${browser_name}    ${url}
    [Documentation]    Launch the browser in Chrome, Firefox, Edge, or Safari with a fixed size.
    IF    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'
        Open Chrome Browser    ${url}
    ELSE IF    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'
        Browser.Open Browser    ${url}    Firefox
    ELSE IF    '${browser_name}'=='Microsoft Edge' or '${browser_name}'=='Edge' or '${browser_name}'=='edge'
        Browser.Open Browser    ${url}    Edge
    ELSE IF    '${browser_name}'=='Safari' or '${browser_name}'=='safari' or '${browser_name}'=='sf'
        Browser.Open Browser    ${url}    Safari
    ELSE IF    '${browser_name}'=='Headless' or '${browser_name}'=='hls'
        Open Headless Chrome    ${url}
    ELSE
        Fail    ${browser_name} is not a valid browser
    END

Fail And Take Screenshot
    [Arguments]    ${message}
    [Documentation]    Take a Screenshot Fail the test case and displays message.
    SeleniumLibrary.Capture Page Screenshot
    Fail    ${message}

Read TestData From Excel
    [Arguments]    ${tc_id}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${expected_data}    Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}    ${tc_id}    ${sheet_name}
    RETURN    ${expected_data}

Update Dynamic Value
    [Arguments]    ${locator}    ${value}
    [Documentation]    It replace the string where ever you want.
    ...    Example:
    ...    web_common.Update Dynamic Value locator replace_string
    ${xpath}    Replace String    ${locator}    replaceText    ${value}
    RETURN    ${xpath}

Wait Until Element Is Clickable And Click
    # robocop: disable=unused-variable
    [Arguments]    ${locator}    ${time_out}
    [Documentation]    It will wait until element is clickable and click the element
    FOR    ${key}    IN RANGE    1    ${time_out}
        ${status}    Run Keyword And Return Status    SeleniumLibrary.Click Element    ${locator}
        IF    '${status}'=='True'    BREAK
        Wait Until Time    1
        CONTINUE
    END
    IF    '${status}'=='False'
        Fail And Take Screenshot    Element is not clickable even after waiting for ${time_out}
    END

Scroll To Element
    [Arguments]    ${locator}
    [Documentation]    Scroll until element visible by using coordinates
    ${horizontal_position}    SeleniumLibrary.Get Horizontal Position    ${locator}
    ${vertical_position}    SeleniumLibrary.Get Vertical Position    ${locator}
    SeleniumLibrary.Execute Javascript    window.scrollTo(${horizontal_position},${vertical_position})

Verify String Should Be Equal
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify strings should be equal
    ${status}    Run Keyword And Return Status    Should Be Equal    ${expected}    ${actual}    ignore_case=True
    # Log Expected And Actual Results    ${actual}    ${expected}
    IF    '${status}'=='False'    Fail And Take Screenshot    ${expected} is not equal to ${actual}

Verify String Should Not Be Equal
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify strings should not be equal
    ${status}    Run Keyword And Return Status    Should Not Be Equal    ${expected}    ${actual}
    IF    '${status}'=='False'
        Fail And Take Screenshot    ${expected} is equal to ${actual}
    END

Click And Wait For Element
    # robocop: disable=unused-variable
    [Arguments]    ${click_locator}    ${future_element}    ${message}=None
    [Documentation]    Click Until Next Element is Displayed
    SeleniumLibrary.Wait Until Element Is Visible    ${click_locator}    ${SHORT_WAIT}    ${message}
    FOR    ${key}    IN RANGE    1    4
        SeleniumLibrary.Click Element    ${click_locator}
        ${status}    Run Keyword And Return Status    SeleniumLibrary.Wait Until Element Is Visible    ${future_element}    ${SHORT_WAIT}
        IF    '${status}'=='True'    BREAK
        Wait Until Time    1
    END
    IF    '${status}'=='False'    Fail And Take Screenshot    ${message}

Click Until Element Is Invisible
    # robocop: disable=unused-variable
    [Arguments]    ${click_locator}
    [Documentation]    click until element is disappears
    SeleniumLibrary.Wait Until Element Is Visible    ${click_locator}    ${MEDIUM_WAIT}    ${click_locator} is not visible
    FOR    ${key}    IN RANGE    1    5
        ${wait_status}    Run Keyword And Return Status    SeleniumLibrary.Wait Until Element Is Not Visible    ${click_locator}    ${SHORT_WAIT}
        IF    '${wait_status}'=='True'    BREAK
        Javascript Click    ${click_locator}
        Wait Until Time    2
    END
    IF    '${wait_status}'=='False'    Fail And Take Screenshot    ${click_locator} is still visible

Scroll Till Element Is Visible
    # robocop: disable=unused-variable
    [Arguments]    ${locator}
    [Documentation]    Scroll Till Element is Visible
    FOR    ${key}    IN RANGE    1    4
        Wait Until Time    1
        ${status}    Run Keyword And Return Status    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${SHORT_WAIT}    locator is not visible
        IF    '${status}'=='True'    BREAK
        Scroll To Element    ${locator}
    END
    IF    '${status}'=='False'    Fail And Take Screenshot    ${locator} is not displayed

Verify String Should Contain
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify strings should be equal
    ${status}    Run Keyword And Return Status    Should Contain    ${expected}    ${actual}    ignore_case=True
    # Log Expected And Actual Results    ${actual}    ${expected}
    IF    '${status}'=='False'    Fail And Take Screenshot    ${expected} doesn't contain ${actual}

Verify String Should Not Contain
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify String Should not Contain
    ${status}    Run Keyword And Return Status    Should Not Contain    ${expected}    ${actual}
    IF    '${status}'=='False'
        Fail And Take Screenshot    ${expected} does contain ${actual}
    END

Wait Till Loading Icon Is Invisible
    [Arguments]    ${locator}    ${time_out}=60
    [Documentation]    Wait Till Loading Icon Is Invisible
    ${status}    Run Keyword And Return Status    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${MEDIUM_WAIT}
    IF    '${status}'=='True'
        FOR    ${key}    IN RANGE    1    ${time_out}
            ${status}    Run Keyword And Return Status   SeleniumLibrary. Element Should Be Visible    ${locator}
            IF    '${status}'=='False'    BREAK
            Wait Until Time    1
        END
        IF    '${status}'=='True'
            Fail And Take Screenshot    Loading Icon is Still Visible
        END
    END

Update Dynamic Values
    [Arguments]    ${locator}    ${value1}    ${value2}    ${value3}=None
    [Documentation]    It replace two strings where ever you want.
    ${locator_new}    Replace String    ${locator}    replaceText1    ${value1}
    ${xpath}    Replace String    ${locator_new}    replaceText2    ${value2}
    IF    '${value3}'=='None'
        RETURN    ${xpath}
    ELSE IF    '${value3}'!='None'
        ${xpath1}    Replace String    ${xpath}    replaceText3    ${value3}
        RETURN    ${xpath1}
    END

Get Downloads Folder Path
    [Documentation]    This keyword is used to get downloads path
    ${user_home}    Get Environment Variable    UserProfile
    ${DOWNLOADS_FOLDER}    Set Variable    ${user_home}\\Downloads
    Set Global Variable    ${DOWNLOADS_FOLDER}

Log Actual And Expected Results
    [Documentation]    This Keyword is Used to get Expected and Actual Results in Log file
    [Arguments]    ${actual_result}    ${expected_result}
    Log    ${actual_result}
    Log    ${expected_result}

Start Recording
    [Documentation]    This Keyword Is Used to Start Video Recording
    [Arguments]    ${record}    ${alias}=None
    ${name}    Get Unique Test Data    Unique
    IF    '${VIDEO}'=='True' or '${record}'=='True'    ScreenCapLibrary.Start Video Recording    alias=${alias}    name=Video${name}    fps=10    size_percentage=0.7

Stop Recording
    [Documentation]    This Keyword Is Used to Stop Video Recording
    [Arguments]    ${record}    ${alias}=None
    IF    '${VIDEO}'=='True' or '${record}'=='True'    ScreenCapLibrary.Stop Video Recording    alias=${alias}

Should Be Greater Than
    [Arguments]    ${actual}    ${expected}
    Should Be True    ${actual} > ${expected}