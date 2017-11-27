*** Settings ***
Resource          Genric_Keywords.robot
Resource          Genric_Variable.robot
Resource          Oracle_SBC_Keywords.txt
Resource          Affirmed_SAEGW.txt
Library           Python_Script/Library.py

*** Test Cases ***
test
    AvailabilityZone_Validation

test2
    @{FlvrParam}    Parseconfdata    ${CURDIR}\\Config\\SBC-Flavor.txt    ${Label}
    ${Ram}    Get From List    ${FlvrParam}    0
    ${Disk}    Get From List    ${FlvrParam}    1
    ${CPU}    Get From List    ${FlvrParam}    2
    ${FlavourName}    Get From List    ${FlvrParam}    3
    Set Global Variable    ${FlavourName}
    @{Server}    ImportDetails    ${CURDIR}\\Config\\testfile.txt    ${Label}
    Comment    ${label}    Set Variable    FlavourDetails
    Comment    ${path}    Set Variable    ${CURDIR}\\Config\\SBC-Flavor.txt
    ${str}    Catenate    nova flavor-create    ${FlavourName}    auto    ${Ram}    ${Disk}
    ...    ${CPU}
    write    ${str}
    sleep    5
    ${output}    read
    log    ********************Create Flavor Complete*****************************

test3
    @{Server}    ImportDetails    ${CURDIR}\\Config\\testfile.txt    ${Label}
    Server_Login    @{Server}
    SBC_CreateFlavor
    SBC_CreateImage
    SBC_OnboardVM
    Comment    SBC_SecurityGroupRules
    SBC Configuration

test4
    @{Server}    ImportDetails    ${CURDIR}\\Config\\testfile.txt    ${Label}
    Server_Login    @{Server}
    Wait Until Keyword Succeeds    2    6    write    ssh -o "StrictHostKeyChecking no" user@172.18.0.183
    sleep    5
    ${Output}    read
    Comment    ${result}    Run Keyword And Return Status    Should Not Contain    ${Output}    Connection refused
    Comment    Wait Until Keyword Succeeds    2    6

test5
    Get_SBC-IP
    sleep    3
    write    clear
    ${i}    Set Variable    0
    : FOR    ${i}    IN RANGE    0    5
    \    ${store}    catenate    ping    -c 1    ${MGmt_IP}
    \    Write    ${store}
    \    sleep    2
    \    ${Output}    read
    \    ${status}    Run Keyword And Return Status    Should Contain    ${Output}    ttl=64
    \    Run Keyword If    ${status}==False    Continue For Loop
    \    Exit For Loop

test6
    Comment    ${i}    Set Variable    0
    : FOR    ${i}    IN RANGE    0    4
    \    Open Connection    10.53.214.10
    \    ${status}    Run Keyword And Return Status    Login    root    techm123
    \    Run Keyword If    ${status}==False    Continue For Loop
    \    Exit For Loop

test7
    :FOR    ${i}    IN RANGE    0    5
    \    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    \    Set Global Variable    @{Server}
    \    ${Index}    Server_Login    @{Server}
    \    SBC_CreateFlavor    #This Keyword creates Flavor on Openstack
    \    Flavor_Validation    #This Keyword Perform the validation of Flavor Created above
    \    SBC_CreateImage    #This Keyword Upload the image from local machine to Controller and create Image on Openstack
    \    Image_Validation    #This Keyword Perform the validation of Image Created above
    \    SBC_OnboardVM    #This Keyword \ create Intance on Openstack ,which use the flavor and Image Created above.
    \    Onboard_Validation    ${Index}    #This Keyword Perform the validation of Instance Created above
    \    AvailabilityZone_Validation    #This Keyword Perform the validation of Instance Created on Which Compute
    \    Networks_Validation
    \    SBC Configuration    #This Keyword do the port updation,password update,setup entitlements ,Configuration.
    \    Comment    ${Controller_Index}    SBC_Start trace
    \    Launch_App    #Testcase Execution starts here
    \    Configure_App    oracle1    sip:oracle1@example.demo    oracle1@example.demo    example.demo    oracle
    \    Register
    \    sleep    6
    \    CloseApplication
    \    sleep    5
    \    Comment    SBC_Stop trace    ${Controller_Index}    TC1_Register.pcap    #stop the trace on PCSCF
    \    Comment    Comment    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC1_Register.pcap
    \    log    P-CSCF trace Stopped...!
    \    Comment    sleep    6
    \    Comment    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "REGISTER" && sip.Expires == 300"
    \    Comment    Run Keyword If    '${Status_Code}' != '200'    Fail    Not Registered..........!
    \    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    \    Server_Login    @{Server}
    \    write    nova flavor-delete ${FlavourName}    #Remove Flavor
    \    sleep    4
    \    write    nova image-delete ${ImageName}    #Remove Image
    \    sleep    4
    \    write    nova delete ${VNFName}    # Remove Instance
    \    sleep    4
    \    read
    \    sleep    20
    \    Continue For Loop
