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

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

powercfg /change monitor-timeout-dc 0
powercfg /change monitor-timeout-ac 0

powercfg /change standby-timeout-dc 0
powercfg /change standby-timeout-ac 0

powercfg /change disk-timeout-dc 0
powercfg /change disk-timeout-ac 0

powercfg /change hibernate-timeout-dc 0
powercfg /change hibernate-timeout-ac 0

powercfg /getactivescheme > C:\tmp1.txt
C:\tmp1.txt
del C:\tmp1.txt

::END OF YOUR CODE::

echo.
echo...Script Complete....
echo.

pause

