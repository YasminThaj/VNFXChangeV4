*** Settings ***
Resource          Genric_Keywords.robot
Resource          Genric_Variable.robot
Resource          Oracle_SBC_Keywords.txt
Library           SSHLibrary
Library           Python_Script/Library.py
Library           ImageHorizonLibrary
Library           String
Library           Collections
Library           Process

*** Test Cases ***
TC1_Verification of on-boarded vnf on RHOSP
    [Documentation]    Verify the Cloud environment (RHOSP) before we start Onboarding of VNF VM’s process.
    [Tags]    Onboard
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Set Global Variable    @{Server}
    ${Index}    Server_Login    @{Server}
    SBC_CreateFlavor    #This Keyword creates Flavor on Openstack
    Flavor_Validation    #This Keyword Perform the validation of Flavor Created above
    SBC_CreateImage    #This Keyword Upload the image from local machine to Controller and create Image on Openstack
    Image_Validation    #This Keyword Perform the validation of Image Created above
    SBC_OnboardVM    #This Keyword \ create Intance on Openstack ,which use the flavor and Image Created above.
    Onboard_Validation    ${Index}    #This Keyword Perform the validation of Instance Created above
    AvailabilityZone_Validation    #This Keyword Perform the validation of Instance Created on Which Compute
    Networks_Validation
    SBC Configuration    #This Keyword do the port updation,password update,setup entitlements ,Configuration.
    [Teardown]    Close All Connections

TC2_Verify able to login/logout into vSBC
    [Tags]    Onboard
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    log    **************** Configuration Start ************
    # phy-interface
    sleep    5
    Write    ssh -o "StrictHostKeyChecking no" user@${SBC_Mgmt_IP}
    sleep    5
    Comment    ${Output}    Read
    write    ${SBC_NewPassword}
    sleep    3
    ${Output}    read
    Should Contain    ${Output}    SBC>
    log    login to vsbc successful******
    write    exit
    SLEEP    2
    ${Output}    read
    Should Contain    ${Output}    [root@controller ~(keystone_admin)]#
    Log    Logout from vSBC Successful****
    [Teardown]    Close All Connections

TC3_Verify ping from all network interfaces of vSBC
    [Tags]    Onboard
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    log    **************** Configuration Start ************
    # phy-interface
    sleep    5
    Write    ssh -o "StrictHostKeyChecking no" user@${SBC_Mgmt_IP}
    sleep    5
    Comment    ${output}=    Read
    write    ${SBC_NewPassword}
    sleep    2
    write    en
    sleep    1
    write    ${SBC_NewPassword}
    Comment    ${output}=    Read
    sleep    2
    Comment    Write    ifconfig -a    #this command is not working properly
    Comment    ${output}    read
    ${HOST}    Get From List    ${Server}    0
    ${store}    catenate    ping    ${HOST}
    Write    ${store}
    sleep    10
    ${output}    read
    Should Contain    ${output}    time
    log    pinging successful for controller****
    ${store}    catenate    ping    ${DEFAULT-GATEWAY}
    Write    ${store}
    sleep    10
    ${output}    read
    Should Contain    ${output}    time
    log    pinging successful for default gateway****​
    [Teardown]    Close All Connections

TC4_Accesing SBC Platform
    [Tags]
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    Comment    Login    ${SBC USERNAME}    ${SBC NEW PASSWORD}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    Open Connection    ${SBC_Mgmt_IP}
    Login    ${SBC_Username}    ${SBC NEW PASSWORD}
    Write    en
    sleep    2
    write    ${SBC NEW PASSWORD}
    Write    configure terminal
    sleep    3
    ${output}    Read
    Should Contain    ${output}    (configure)#
    sleep    2
    write    exit
    ${output}    read

TC8_management IP assignment to SBC Platform
    [Tags]    TC8
    @{Server}    ImportDetails    ${CURDIR}\\Config\\SBC_Config.txt    ${Label}
    Server_Login    @{Server}
    Bootparam    #add steps

TC9_Setting Up Entitlements for SBC
    [Tags]    TC9
    @{Server}    ImportDetails    ${CURDIR}\\Config\\SBC_Config.txt    ${Label}
    Server_Login    @{Server}
    Setup Entitlements

TC10_verfying SBC conf
    [Tags]    TC10
    @{Server}    ImportDetails    ${CURDIR}\\Config\\SBC_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    Open Connection    ${SBC_Mgmt_IP}
    Login    ${SBC_Username}    ${SBC NEW PASSWORD}
    Write    show running-config
    sleep    5
    ${output}    read
    Should Contain    ${output}    10.80.1.211    #CSMIP
    Write    en
    Write    ${SBC NEW PASSWORD}
    Write    show running-config
    sleep    5
    ${output}    read
    Should Contain    ${output}    10.80.1.211    #CSMIP

TC5_Creating New element in SBC
    [Tags]    TC5
    @{Server}    ImportDetails    ${CURDIR}\\Config\\SBC_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova list | grep -i ${VNFName}| awk -F ";" '{print $2}' | awk -F "=" '{print $2}'| awk -F " \ " '{print $1}'    #get IP of SBC
    sleep    10
    ${Output}    read
    @{Output}    Split String    ${Output}
    ${SBC_Mgmt_IP}    Get From List    ${Output}    0
    Open Connection    ${SBC_Mgmt_IP}
    Login    ${SBC_Username}    ${SBC NEW PASSWORD}
    Write    configure terminal
    ${output}    read
    Write    system
    ${output}    read
    Write    snmp-community
    ${output}    read
    Write    show
    ${output}    read
    Write    community-name sss
    ${output}    read
    Write    show config
    ${output}    read
    Should Contain    ${output}    sss

TC6_Deleting Element from SBC
    [Tags]    TC6
    @{Server}    ImportDetails    ${CURDIR}\\Config\\SBC_Config.txt    ${Label}
    Server_Login    @{Server}
    Login    ${SBC USERNAME}    ${SBC NEW PASSWORD}
    Write    ssh -o "StrictHostKeyChecking no" user@${MGT-IP}
    Write    configure terminal
    ${output}    read
    Write    ?
    Write    snmp-community
    ${output}    read
    Write    show
    ${output}    read
    Write    community-name <name>
    ${output}    read
    Write    show config
    ${output}    read
    Write    no
    ${output}    read
    Write    enter
    ${output}    read
    Write    show config
    ${output}    read

TC7_SBC files Back-up
    [Tags]    TC7
    @{Server}    ImportDetails    ${CURDIR}\\Config\\SBC_Config.txt    ${Label}
    Server_Login    @{Server}
    Elevated Access    #add steps of elevated access
    Write    backup-config sss
    ${output}    read
    sleep    5
    Write    display-backups
    ${output}    read

TC11_Offboard the Vnf on RHOSP
    @{Server}    ImportDetails    ${CURDIR}\\Config\\Enterprise_Config.txt    ${Label}
    Server_Login    @{Server}
    write    nova flavor-delete ${FlavourName}    #Remove Flavor
    sleep    4
    write    nova image-delete ${ImageName}    #Remove Image
    sleep    4
    write    nova delete ${VNFName}    # Remove Instance
    sleep    4
    read
