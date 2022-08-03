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

PowerShell -command "powercfg /change monitor-timeout-dc 0; powercfg /change monitor-timeout-ac 0; powercfg /change standby-timeout-dc 0; powercfg /change standby-timeout-ac 0; powercfg /change disk-timeout-dc 0; powercfg /change disk-timeout-ac 0; powercfg /change hibernate-timeout-dc 0; powercfg /change hibernate-timeout-ac 0; powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 |  Out-Null; $cmdOutput = powercfg /getactivescheme; if (($cmdOutput -match '(Ultimate)') -or ($cmdOutput -match '(Najwyzsza wydajnosc)')) {'PowerPlan has been set to:	*** Ultimate performance ***';  Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline;  Write-Output ''; Write-Output ''}else {'***	I was unable to set PowerPlan to Ultimate, I will try to set HighPerformance at least	 ***'; Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline; Write-Output ''; Write-Output ''; powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c; $cmdOutput = powercfg /getactivescheme; if (($cmdOutput -match '(High performance)') -or ($cmdOutput -match '(Wysoka wydajnosc)')) {'PowerPlan has been set to:	*** High performance ***'; Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline; Write-Output ''; Write-Output '';}else {'*** Attention ***	I was unable to set PowerPlan :(	*** Attention ***'; Write-Host 'Active ' -NoNewline; Write-Host $cmdOutput -NoNewline; Write-Output ''; Write-Output '';}}; $HubID = (Get-WmiObject Win32_USBHub).PNPDeviceID; $USBControllerID = (Get-WmiObject Win32_USBController).PNPDeviceID; $HubIDCounter = $HubID.Count; $USBControllerIDCounter = $USBControllerID.Count; for ($i = 0; $i -lt $USBControllerIDCounter ; $i++){$USBControllerID[$i] = $USBControllerID[$i].SubString(0, $USBControllerID[$i].IndexOf('REV')+6); $PowerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | Where {$_.InstanceName.Contains($USBControllerID[$i])}; $PowerMgmt.Enable = $False; $PowerMgmt.psbase.Put() |  Out-Null}; $PowerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | Where {$_.InstanceName.Contains('USB')}; for ($i = 0; $i -lt $PowerMgmt.Count ; $i++){$PowerMgmt[$i].Enable = $False; $PowerMgmt[$i].psbase.Put() |  Out-Null}; Write-Output 'I will now configure the J5 net adapters settings, this may take a while, so be patient...'; Write-Output ''; Write-Output ''; [object[]]$netAdapters = Get-NetAdapter -InterfaceDescription 'ASIX*'; $netAdaptersCounter = $netAdapters.length; if($netAdaptersCounter -lt 1){Write-Output '*** 	There is no J5 net adapter connected to the PC!		***'}else {for ($i = 0; $i -lt $netAdaptersCounter ; $i++){Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Energy-Efficient Ethernet' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'SelectiveSuspend' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'AutoDetach' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Speed & Duplex' -DisplayValue '1.0 Gbps Full Duplex'; Restart-NetAdapter -Name $netAdapters[$i].name}};  Write-Output ''; Write-Output 'I will now configure the Intel Ethernet adapters settings, this may take a while, so be patient...'; Write-Output ''; Write-Output ''; [object[]]$netAdapters = Get-NetAdapter -InterfaceDescription '*Intel* *Ethernet*'; $netAdaptersCounter = $netAdapters.length; if($netAdaptersCounter -lt 1){Write-Output '*** 	There is no Intel Ethernet adapter connected to the PC!		***'}else {for ($i = 0; $i -lt $netAdaptersCounter ; $i++){Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Energy Efficient Ethernet' -DisplayValue 'Off'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Link Speed Battery Saver' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Reduce Speed On Power Down' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Selective Suspend' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Speed & Duplex' -DisplayValue '1.0 Gbps Full Duplex';  Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'System Idle Power Saver' -DisplayValue 'Disabled'; Set-NetAdapterAdvancedProperty -Name $netAdapters[$i].name -DisplayName 'Ultra Low Power Mode' -DisplayValue 'Disabled'; Restart-NetAdapter -Name $netAdapters[$i].name}; Write-Output '*** 	All Done! Check the steps above to see if the power plan has been changed correctly! 	***'}; Write-Output '';"


::END OF YOUR CODE::

echo.
echo...Script Complete....
echo.

pause



