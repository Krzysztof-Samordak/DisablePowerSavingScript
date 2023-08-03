@echo off
if _%1_==_payload_  goto :payload

:getadmin
    echo %~nx0: elevating self
    set vbs=%temp%\getadmin.vbs
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%"
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof

:payload

::ENTER YOUR CODE BELOW::

echo|set /p="Adding Inbound Rule for HardwareTest3 -" 
netsh advfirewall firewall add rule name="HardwareTest3" dir=in program="C:\Program Files\3Shape\HardwareTest3.Trios\ThreeShape.Scanner.HardwareTest.Trios.exe" action=allow
echo|set /p="Adding Outbound Rule for HardwareTest3 -" 
netsh advfirewall firewall add rule name="HardwareTest3" dir=out program="C:\Program Files\3Shape\HardwareTest3.Trios\ThreeShape.Scanner.HardwareTest.Trios.exe" action=allow

echo.
echo...Script Complete....
echo.

pause



