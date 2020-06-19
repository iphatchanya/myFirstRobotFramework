*** Settings ***
Library     String

*** Variables ***
${text}  hello world

*** Test Cases ***
TC01 Uppercase String
    Check Uppercase     ${text}

*** Keywords ***
Check Uppercase
    [Arguments]     ${path}
    ${str} =     Convert to Uppercase   ${path}
    Should Be Equal     ${str}   HELLO WORLD