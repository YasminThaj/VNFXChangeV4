*** Settings ***
Resource          Genric_Keywords.robot
Resource          Genric_Variable.robot
Resource          Oracle_SBC_Keywords.txt
Library           SSHLibrary
Resource          Oracle_SBC_Keywords.txt
Library           AutoItLibrary
Resource          Affirmed_SAEGW.txt
Resource          Genric_Keywords.robot
Resource          Python_Script/Library.py

*** Test Cases ***
TC1_Create VNF VM Flavor
    Affirmed_CreateFlavour_MCM
    Affirmed_CreateFlavour_CSM
    Affirmed_CreateFlavour_SSM
    Affirmed_Flavor_Validation

TC2_Upload the VNF VM image to Glance
    Affirmed_CreateImage_MCM
    Affirmed_CreateImage_CSM
    Affirmed_CreateImage_SSM
    Affirmed_Image_Validation

TC3_Securitygrouppolicy
    Affirmed_SecurityPolicy_MCM
    Affirmed_SecurityPolicy_CSM
    Affirmed_SecurityPolicy_SSM
    Security_Validation

TC4_Verify the On-boarded VNF VM on RHOSP
    Affirmed_Onboarding_MCM
    Affirmed_Onboarding_CSM
    Affirmed_Onboarding_SSM
    Affirmed_Onboarding_Validation
