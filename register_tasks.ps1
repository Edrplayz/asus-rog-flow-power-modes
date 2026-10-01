schtasks /Create /TN "ModeScripts\StreetMode" /XML "C:\Users\wwwed\Desktop\usefulprograms\SynologyDrive\powerplanautomation\task_street.xml" /F
schtasks /Create /TN "ModeScripts\HomeMode"   /XML "C:\Users\wwwed\Desktop\usefulprograms\SynologyDrive\powerplanautomation\task_home.xml"   /F
schtasks /Create /TN "ModeScripts\VideoMode"  /XML "C:\Users\wwwed\Desktop\usefulprograms\SynologyDrive\powerplanautomation\task_video.xml"  /F
"Tasks registered OK" | Out-File "C:\Users\wwwed\Desktop\usefulprograms\SynologyDrive\powerplanautomation\setup_result.txt"
