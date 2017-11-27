@echoff
cd C:\xampp\htdocs\VNFXchange\IMSonboard
psexec \\10.53.172.4 -u Admin -p admin123 -i -s C:\Users\Admin\Desktop\Sukesh-Automation\RobotFramework\Genric_Script\BatFiles\SBC_onboard.bat
timeout 1000

cd C:\Users\Vinoy\Desktop
start ftp -i -s:ftpcommands.txt