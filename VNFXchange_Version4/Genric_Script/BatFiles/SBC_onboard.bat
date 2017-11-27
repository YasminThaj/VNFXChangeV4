cd C:\Users\Admin
start cmd /k pybot.bat -d C:\Users\Admin\Desktop\Sukesh-Automation\RobotFramework\Genric_Script\Config -i Onboard C:\Users\Admin\Desktop\Sukesh-Automation\RobotFramework\Genric_Script\SBC_Onboarding_TestCases.robot
@echo off
ping -n 750 -w 1000  0.0.0.1 > NULL

