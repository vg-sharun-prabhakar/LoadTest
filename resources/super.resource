*** Settings ***
Documentation     This super.resource file has all imported Libraries and Resources
Library           Collections
Library           DateTime
Library           String
Library           OperatingSystem
Library           SeleniumLibrary
Library           RequestsLibrary
Library           DatabaseLibrary
Library           Collections
Library           JSONLibrary
Library           RetryFailed
Library           Pdf2TextLibrary
Library           ScreenCapLibrary
Library           CacheLibrary
Library           ../library/CustomLibrary.py
Library           ../library/JSONManipulation.py
Library           ../library/PKCELibrary.py
Resource          common-variables.resource
Resource          keywords/common.resource
Resource          keywords/api-keywords.resource
Resource          keywords/auth.resource
