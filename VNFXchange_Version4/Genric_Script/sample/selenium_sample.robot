*** Settings ***
Library           Selenium2Library
Library           BuiltInLibrary

*** Test Cases ***
tc1
    Open Browser    https://easy.techmahindra.com/    ff
    Maximize Browser Window
    Location Should Be    https://easy.techmahindra.com/
    Input Text    id=txtLanId
    Input Password    id=txtPassword
    Click Button    id=btnlogin
    Page Should Contain Element    xpath=//span[contains(text(),'PACE')]
    Click Button    id=lnkLogout1
    Page Should Contain Element    id=main-message
    Close Browser
    log    successful session***

sample_tc1
