*** Settings ***
Documentation     This common variables file has all the common variable


*** Variables ***
${BASE_URL}         https://www.google.com/
${BROWSER_NAME}     chrome
${USER}             sampleuser
${USER_PASSWORD}    welcome@1
${SHORT_WAIT}     5
${MEDIUM_WAIT}    20
${LONG_WAIT}      40
${TESTDATA_FOLDER}    ${EXECDIR}\\Testdata\\Testdata.xlsx
${JSONPATH}       ${EXECDIR}\\tests                     #D://NGP//Robotframework_Template//JsonFiles
${SCREENSHOT}     True
${VIDEO}          False    
${DB_HOST}  localhost
${DB_PORT}  2023
${DB_NAME}  RobotDB
${DB_USER}  Drona
${DB_PASSWORD}  valgen@123
${GATEWAY_BASE_URL}    http://127.0.0.1:1880
