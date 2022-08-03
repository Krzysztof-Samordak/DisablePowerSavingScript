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

PowerShell -command "powercfg /change monitor-timeout-dc 0; powercfg /change monitor-timeout-ac 0; powercfg /change standby-timeout-dc 0; powercfg /change standby-timeout-ac 0; powercfg /change disk-timeout-dc 0; powercfg /change disk-timeout-ac 0; powercfg /change hibernate-timeout-dc 0; powercfg /change hibernate-timeout-ac 0; powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 |  Out-Null; $cmdOutput = powercfg /getactivescheme; if (($cmdOutput -match '(Ultimate)') -or ($cmdOutput -match '(Najwyzsza wydajnosc)')) {'PowerPlan has been set to:	*** Ultimate performance ***';  Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline;  Write-Output ''; Write-Output ''}else {'***	I was unable to set PowerPlan to Ultimate, I will try to set HighPerformance at least	 ***'; Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline; Write-Output ''; Write-Output ''; powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c; $cmdOutput = powercfg /getactivescheme; if (($cmdOutput -match '(High performance)') -or ($cmdOutput -match '(Wysoka wydajnosc)')) {'PowerPlan has been set to:	*** High performance ***'; Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline; Write-Output ''; Write-Output '';}else {'*** Attention ***	I was unable to set PowerPlan :(	*** Attention ***'; Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline; Write-Output ''; Write-Output '';}};  Write-Output 'I will now configure the J5 net adapters settings, this may take a while, so be patient...'; Write-Output ''; Write-Output ''; [object[]]$netAdapters = Get-NetAdapter -InterfaceDescription 'ASIX*'; $netAdaptersCounter = $netAdapters.length; if($netAdaptersCounter -lt 1){Write-Output '*** 	There is no J5 net adapter connected to the PC!		***'}else {for ($i = 0; $i -lt $netAdaptersCounter ; $i++){Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Energy-Efficient Ethernet' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'SelectiveSuspend' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'AutoDetach' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Speed & Duplex' -DisplayValue '1.0 Gbps Full Duplex'; Restart-NetAdapter -Name $netAdapters[$i].name}; Write-Output '*** 	All Done! Check the steps above to see if the power plan has been changed correctly! 	***'}; Write-Output '';"

::END OF YOUR CODE::

echo.
echo...Script Complete....
echo.

pause



