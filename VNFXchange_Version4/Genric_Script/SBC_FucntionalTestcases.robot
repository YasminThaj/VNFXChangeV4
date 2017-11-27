*** Settings ***
Library           SSHLibrary
Library           AutoItLibrary
Library           Python_Script/Iteration.py
Library           Selenium2Library
Library           ImageHorizonLibrary
Library           String
Library           Collections
Library           Process
Resource          Oracle_SBC_Keywords.txt

*** Test Cases ***
TC1_Register User through SBC
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC1
    [Setup]
    Comment    ${Controller_Index}    SBC_Start trace
    Launch_App    #Testcase Execution starts here
    Configure_App    oracle1    sip:oracle1@example.demo    oracle1@example.demo    example.demo    oracle
    Register
    sleep    6
    CloseApplication
    sleep    5
    Comment    SBC_Stop trace    ${Controller_Index}    TC1_Register.pcap    #stop the trace on PCSCF
    Comment    Comment    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC1_Register.pcap    #Moving file to directory and rename it as per testcase
    log    P-CSCF trace Stopped...!
    Comment    sleep    6
    Comment    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "REGISTER" && sip.Expires == 300"
    Comment    Run Keyword If    '${Status_Code}' != '200'    Fail    Not Registered..........!
    [Teardown]    Close All Connections

TC2_Make call from Orginiator,RemoteUser drop the call.
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Initiating the call ,while in ringing state originator cancel the call and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC10
    [Setup]
    ${Controller_Index}    SBC_Start trace
    Register On RemoteMachine    ${Proxy_IP}
    Launch_App
    Configure_App    oracle1    sip:oracle1@example.demo    oracle1@example.demo    example.demo    oracle
    Register
    MakeCall    oracle2    #Initiating the call
    CallAnswer_on_RemoteMachine
    sleep    20
    DropCall By RemoteMachine
    tabloop    5
    AutoItLibrary.Send    {ENTER}
    log    Call drop by remote machine successfully***
    sleep    5
    win activate    Boghe - IMS/RCS Client
    Win Close    Boghe - IMS/RCS Client    #Close the Application
    Remote.Close Bhogie
    SBC_Stop trace    ${Controller_Index}
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC5_RingingState_CancelCall_PCSCF.pcap
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register_PCSCF.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "INVITE""    #validation of Call
    Run Keyword If    '${Status_Code}' != '200'    Fail    Busy unsuccessful
    [Teardown]    Close All Connections

TC3_Un_Registering User
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we areUn-Registering \ and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC2
    [Setup]
    [Template]
    ${Controller_Index}    SBC_Start trace
    Launch_App
    Configure_App    tasuser1
    Register
    Log    IMS CLient Registered
    sleep    5
    Rev Tab    5
    AutoItLibrary.Send    {DOWN 4}
    AutoItLibrary.Send    {ENTER}    #Un registering Application
    sleep    5
    win activate    Boghe - IMS/RCS Client    #Close Application
    Win Close    Boghe - IMS/RCS Client
    log    Application Closed
    SBC_Stop trace    ${Controller_Index}
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC2_Un-Register_PCSCF.pcap
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register_PCSCF.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "REGISTER" && sip.Expires == 0"
    Run Keyword If    '${Status_Code}' != '200'    Fail    Not Un-Registered..........!
    [Teardown]    Close All Connections

TC4,9_Re-Registration of Application to SBC
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Initiating the call ,call established originator drop the call and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC3    TC8
    [Setup]
    ${Controller_Index}    SBC_Start trace
    Launch_App    #Testcase Execution starts here
    Configure_App    tasuser1
    Register
    sleep    4
    Close Application
    SBC_Stop trace    ${Controller_Index}    #stop the trace on PCSCF
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC3_Re_register_PCSCF.pcap    #Moving file to directory and rename it as per testcase
    [Teardown]    Close All Connections

TC5_ Unknown user try to Register
    [Tags]    TC4
    [Setup]
    ${Controller_Index}    SBC_Start trace
    Launch_App    #Testcase Execution starts here
    Configure_App    tasuser1
    Register
    sleep    5
    Close Application
    SBC_Stop trace    ${Controller_Index}    #stop the trace on PCSCF
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC4_Unknown_userRegister_PCSCF.pcap    #Moving file to directory and rename it as per testcase
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC4_unknown_userRegister.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "REGISTER""
    Run Keyword If    '${Status_Code}' != '403'    Fail    Unknown User is \ Registered successful..........!
    [Teardown]    Close All Connections

TC6,10_Register User using Wrong Credentials
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC5    TC9
    [Setup]
    ${Controller_Index}    SBC_Start trace
    Launch_App    #Testcase Execution starts here
    Configure_App    oracle
    Register
    sleep    5
    Close Application
    SBC_Stop trace    ${Controller_Index}    #stop the trace on PCSCF
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC5_Register_wrong_ credentials_PCSCF.pcap    #Moving file to directory and rename it as per testcase
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register_PCSCF.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "REGISTER""
    Run Keyword If    '${Status_Code}' != '403'    Fail    user registration with wrong credential is successful..........!
    [Teardown]    Close All Connections

TC7_Call busy,When make call
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Initiating the call ,call established originator drop the call and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC6
    [Setup]
    ${Controller_Index}    SBC_Start trace
    Launch_App    #Testcase Execution starts here
    Configure_App    tasuser2
    Register
    MakeCall    tasuser1
    Close Application
    SBC_Stop trace    ${Controller_Index}    #stop the trace on PCSCF
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC1_userbusy_PCSCF.pcap    #Moving file to directory and rename it as per testcase
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register_PCSCF.pcap "sip && sip.Status-Code == 486 && sip.CSeq.method == "INVITE""
    Run Keyword If    '${Status_Code}' != '486'    Fail    Busy unsuccessful
    [Teardown]    Close All Connections

TC8_Call NoAnswer,When make call
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Initiating the call ,call established originator drop the call and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC7
    [Setup]
    ${Controller_Index}    SBC_Start trace
    MakeCall    tasuser2
    SLEEP    60
    Close Application
    SBC_Stop trace    ${Controller_Index}    #stop the trace on PCSCF
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC7_no answer_PCSCF.pcap    #Moving file to directory and rename it as per testcase
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register_PCSCF.pcap "sip && sip.Status-Code ==408 && sip.CSeq.method == "REGISTER" && sip.Expires == 300"
    Run Keyword If    '${Status_Code}' != '408'    Fail    Request timeout for no answer is not successful..........!
    [Teardown]    Close All Connections

TC11_Make call from originator,originator cancel the call while Ringing
    [Documentation]    ************This testcase Explains Using \ IMS Client \ we are registering \ and Initiating the call ,while in ringing state originator cancel the call and Capturing the Pcap files and save it on local machine**************
    [Tags]    TC10
    [Setup]
    ${Controller_Index}    SBC_Start trace
    MakeCall    tasuser1    #Initiating the call
    sleep    10
    tabloop    5
    AutoItLibrary.Send    {ENTER}    #Cancel the call in ringing state
    log    Call Cancelled by the Originator
    sleep    5
    win activate    Boghe - IMS/RCS Client
    Win Close    Boghe - IMS/RCS Client    #Close the Application
    Remote.Close Bhogie
    SBC_Stop trace    ${Controller_Index}
    log    P-CSCF trace Stopped...!
    Rename File    ${Rename_Path}    ims_trace_pcscf.pcap    TC5_RingingState_CancelCall_PCSCF.pcap
    ${Status_Code}    OperatingSystem.Run    tshark -T fields -e sip.Status-Code -r C:\\Users\\Admin\\Desktop\\Sukesh-Automation\\RobotFramework\\Genric_Script\\PcapFiles\\TC1_Register_PCSCF.pcap "sip && sip.Status-Code == 200 && sip.CSeq.method == "INVITE""    #validation of Call
    Run Keyword If    '${Status_Code}' != '200'    Fail    Busy unsuccessful
    [Teardown]    Close All Connections
