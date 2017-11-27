*** Settings ***
Library           Collections
Library           SSHLibrary
Library           BuiltIn
Resource          Genric_Variable.robot
Library           Python_Script/Library.py
Library           OperatingSystem
Library           String

*** Keywords ***
ImportDetails
    [Arguments]    ${ConfigPath}    ${Label}
    @{Param}    Parseconfdata    ${ConfigPath}    ${Label}
    ${server}    Get From List    ${Param}    0
    ${VNFName}    Get From List    ${Param}    1
    ${ImageName}    Get From List    ${Param}    2
    ${DiskFormat}    Get From List    ${Param}    3
    ${ImageFilePath}    Get From List    ${Param}    4
    ${ConatinerFormat}    Get From List    ${Param}    5
    ${FlavorP}    Get From List    ${Param}    6
    ${AvZone}    Get From List    ${Param}    7
    ${Security}    Get From List    ${Param}    8
    ${Protocol}    Get From List    ${Param}    9
    ${Direction}    Get From List    ${Param}    10
    ${Ethertype}    Get From List    ${Param}    11
    ${FN}    Get From List    ${Param}    12
    ${ImageFileName}    Get From List    ${Param}    13
    Comment    ${Nic1}    Get From List    ${Param}    12
    Comment    ${Nic2}    Get From List    ${Param}    13
    Comment    ${Nic3}    Get From List    ${Param}    14
    ${FlavourName}    ${Ext}    Split Extension    ${FN}
    Set Global Variable    ${ImageFileName}
    Set Global Variable    ${FN}    #flavornamewithextension
    Set Global Variable    ${FlavourName}
    Set Global Variable    ${VNFName}
    Set Global Variable    ${server}
    Set Global Variable    ${ImageName}
    Set Global Variable    ${DiskFormat}
    Set Global Variable    ${ImageFilePath}
    Set Global Variable    ${ConatinerFormat}
    Set Global Variable    ${FlavorP}
    Set Global Variable    ${AvZone}
    Set Global Variable    ${Security}
    Set Global Variable    ${Protocol}
    Set Global Variable    ${Direction}
    Set Global Variable    ${Ethertype}
    Comment    Set Global Variable    ${Nic1}
    Comment    Set Global Variable    ${Nic2}
    Set Global Variable    ${VNFName}
    Comment    Set Global Variable    ${Nic3}
    Run Keyword If    ${server}=="RedHat"    Return From Keyword    @{RedHat}
    Run Keyword If    ${server}=="Server2"    Return From Keyword    @{Server2}
    [Teardown]

Server_Login
    [Arguments]    @{Server}
    [Timeout]
    ${HOST}    Get From List    ${Server}    0
    ${USERNAME}    Get From List    ${Server}    1
    ${PASSWORD}    Get From List    ${Server}    2
    :FOR    ${i}    IN RANGE    0    4
    \    ${Index}    Open Connection    ${HOST}    #Login to Server
    \    ${status}    Run Keyword And Return Status    Login    ${USERNAME}    ${PASSWORD}
    \    Run Keyword If    ${status}==False    Continue For Loop
    \    Exit For Loop
    log    *****************ServerLogin_Validation**********************
    Wait Until Keyword Succeeds    20s    2    write    ifconfig | grep inet
    sleep    4
    ${output}    read    #Validation of Server Login
    Should Contain    ${output}    ${HOST}
    log    *****************ServerLogin_Validation Completed**********************
    Wait Until Keyword Succeeds    20s    2    write    source keystonerc_admin    #Openstack Authentication
    ${output}    read
    [Return]    ${Index}

PushimagefiletoServer
    [Arguments]    @{Server}
    ${HOST}    Get From List    ${Server}    0
    ${USERNAME}    Get From List    ${Server}    1
    ${PASSWORD}    Get From List    ${Server}    2
    Comment    Switch Connection    ${Index}
    Comment    Put File    ${ImageFilePath}    /root/auto_heatfiles/
    Comment    Push Imageto Server    ${HOST}    ${USERNAME}    ${PASSWORD}    ${IFP}

Create Flavor
    log    ********************Create Flavor start*****************************
    ${path}    Catenate    SEPARATOR=    ${CURDIR}\\Config\\    ${FN}
    ImportFlavor    ${path}
    ${str}    Catenate    nova flavor-create    ${FlavourName}    auto    ${Ram}    ${Disk}
    ...    ${CPU}
    write    ${str}
    sleep    5
    ${output}    read
    log    ********************Create Flavor Complete*****************************

GlanceImageUpload
    [Timeout]
    log    ******************Create Image on Glance Started*******************
    Comment    Switch Connection    ${Index}
    Comment    ${IN}    Get From List    ${Param}    0    #Image Name Variable
    Comment    ${DF}    Get From List    ${Param}    1    #Disk Format Variable
    Comment    ${IFP}    Get From List    ${Param}    2    #Image File Path
    Comment    ${CF}    Get From List    ${Param}    3    #Container format
    Comment    ${FP}    Get From List    ${Param}    4    #Flavour Path
    ${remotepathwithimagename}    Getimagename    ${ImageFilePath}    ${ImageFileName}
    Comment    ${dstImage}    Catenate    SEPERATOR=/    /root/auto_heatfiles
    Comment    Set Global Variable    ${IN}
    ${str1}    Catenate    glance image-create --name    ${ImageName}
    ${str2}    Catenate    --disk-format    ${DiskFormat}
    ${str3}    Catenate    --file    ${remotepathwithimagename}    #Path of Server
    ${str4}    Catenate    --container-format    ${ConatinerFormat}
    ${str5}    Catenate    ${str1}    ${str2}    ${str4}    ${str3}
    Wait Until Keyword Succeeds    20s    2    write    ${str5}
    sleep    15
    log    ******************Create Image on Glance completed*******************
    ${output}    read

SecurityGroup_Rules
    log    ***************Create Security Group Started******************
    ${str1}    Catenate    neutron security-group-rule-create    ${Security}    --protocol    ${Protocol}    --direction
    ...    ${Direction}    --ethertype    ${Ethertype}
    write    ${str1}
    sleep    10
    ${output}    read

VMCreation
    [Arguments]    ${Label}    ${Nic}
    ${remotepathwithimagename}    Getimagename    ${ImageFilePath}    ${ImageFileName}
    Comment    write    neutron net-list | head -6 | tail -3 | awk -F "|" '{print $2}' >> nicID.txt
    Comment    Get File    /root/nicID.txt    C://Users//Admin//Desktop//Sukesh-Automation//RobotFramework//Genric_Script//Python_Script//
    Comment    Switch Connection    ${Index}
    Comment    @{FlvrParam}    Parseconfdata    ${FlavorP}    ${Label}
    Comment    ${FlavourName}    Get From List    ${FlvrParam}    3
    ${flavor}    Catenate    --flavor    ${FlavourName}
    ${AvailZone}    Catenate    --availability_zone    ${AvZone}
    ${SecurityPol}    Catenate    --security-groups    ${Security}
    Comment    ${image}    Catenate    --image    ${IN}
    ${str}    Catenate    nova boot    ${flavor}    --image    ${ImageName}    ${AvailZone}
    ...    ${SecurityPol}    ${Nic}    --config-drive=true    ${VNFName}
    sleep    5
    Wait Until Keyword Succeeds    20s    2    write    ${str}
    sleep    40
    ${output}    read

Stop_PcapLogs
    [Arguments]    ${Index}
    Switch Connection    ${Index}
    write    ${Stop_PcapTrace}

IXA_Login
    write    ${IXIA_Traffic_Cmd}

GetFiles

known_hostremoval
    write    rm /root/.ssh/known_hosts
    sleep    5
    write    yes

ImportFlavor
    [Arguments]    ${Path}
    [Timeout]
    ${File}    OperatingSystem.Get File    ${Path}
    ${Flavor_list}    Create List
    @{list}    Split To Lines    ${File}
    Comment    ${i}    Set Variable    0
    : FOR    ${line}    IN    @{list}
    \    Comment    log    ${line}
    \    @{data}    Split String From Right    ${line}    :
    \    ${Value}    Get From List    ${data}    1
    \    Append To List    ${Flavor_list}    ${Value}
    ${Ram}    Get From List    ${Flavor_list}    0
    ${Disk}    Get From List    ${Flavor_list}    1
    ${CPU}    Get From List    ${Flavor_list}    2
    Set Global Variable    ${Ram}
    Set Global Variable    ${Disk}
    Set Global Variable    ${CPU}
