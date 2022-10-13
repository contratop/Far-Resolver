# Windows Defender manipulator (Using DefenderCMD)

$whdefendermanipulator = $true



while ($whdefendermanipulator) {
    if ($newlocation) {
        Write-host "New Manual Location detected: $newlocation" -ForegroundColor Cyan
        Set-Location "$newlocation"
    }
    clear-host
    write-host ""
    write-host "----------------------------------------"
    write-host "Windows Defender manipulator" # HEADER
    write-host "----------------------------------------"
 





    # CHECK CMD INIT
    if (test-path -path "C:\Program Files\Windows Defender\MpCmdRun.exe") {
        Write-host "Windows Defender CMD detected!" -ForegroundColor Green
        Set-Location "C:\Program Files\Windows Defender"
    }
    elseif (test-path -path "MpCmdRun.exe") {
        Write-host "Windows Defender CMD Detected!" -ForegroundColor Green
    }
    else {
        Write-Warning "Windows Defender CMD not detected!"
        write-host "[R] Reset location manually"
    }

    write-host ""

    if ((Get-MpComputerStatus).RealTimeProtectionEnabled) {
        write-host "Windows Defender profile detected" -ForegroundColor Green
    }
    elseif ((Get-MpComputerStatus).RealTimeProtectionEnabled -eq $false) {
        write-host "Windows Defender Warnings" -ForegroundColor Red
    }
    else {
        write-warning "Windows Defender profile not detected"
    }

    write-host ""

    if ((Get-MpComputerStatus).IsTamperProtected) {
        write-host "Windows Defender Tamper Protection enabled" -ForegroundColor Yellow
        write-host "Disable for correct manipulation"
    }
    elseif ((Get-MpComputerStatus).IsTamperProtected -eq $false) {
        write-host "Windows Defender Tamper Protection disabled" -ForegroundColor Green
    }
    else {
        write-warning "Windows Defender Tamper Protection unknown"
    }
    # CHECK CMD END


    write-host "----------------------------------------"
    # MENU OPTIONS ######################################################################################
    write-host "1- Clear Threat History"
    write-host "2- Change Windows Defender parameters"
    write-host "3- Restore Threat"
    write-host "4- Update Definitions"
    write-host "5- Scan" # quick & full
    write-host ""
    write-host "[x] Exit"

    $choice = Read-Host "Enter your choice" # CHOICE PROMPT #######

    if ($choice -eq "r") {
        # CHOICE R ###############################
        $newlocation = Read-Host "Enter the new location path"
    }

    if ($choice -eq 1) {
        # CHOICE 1 ###############################
        write-host "Cleaning Threat History..." -ForegroundColor Cyan
        Remove-MpThreat
        if (-not($?)) {
            write-warning "Error while cleaning Threat History"
        }
        else {
            write-host "Threat History cleaned" -ForegroundColor Green
        }
        pause
    }

    if ($choice -eq 2) {
        # CHOICE 2 ###############################
        $whilelocura = $true
        while ($whilelocura) {
            clear-host
            write-host ""
            # INIT ##################################################
            if ((Get-MpComputerStatus).IsTamperProtected) {
                write-host "Windows Defender Tamper Protection enabled" -ForegroundColor Yellow
                write-host "Disable for correct manipulation"
            }
            elseif ((Get-MpComputerStatus).IsTamperProtected -eq $false) {
                write-host "Windows Defender Tamper Protection disabled" -ForegroundColor Green
            }
            else {
                write-warning "Windows Defender Tamper Protection unknown"
            }



            write-host ""
            # CHECK INIT
            if ((Get-MpPreference).DisableRealtimeMonitoring) {
                write-host "Realtime monitoring is disabled" -ForegroundColor Red
                $defenderstatus = 2
            }
            elseif ((Get-MpPreference).DisableRealtimeMonitoring -eq $false) {
                write-host "Realtime monitoring is enabled" -ForegroundColor Green
                $defenderstatus = 1
            }
            else {
                write-host "Realtime monitoring is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableBehaviorMonitoring) {
                write-host "Behavior monitoring is disabled" -ForegroundColor Red
                $behavior = 2
            }
            elseif ((Get-MpPreference).DisableBehaviorMonitoring -eq $false) {
                write-host "Behavior monitoring is enabled" -ForegroundColor Green
                $behavior = 1
            }
            else {
                write-host "Behavior monitoring is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableIOAVProtection) {
                write-host "IOAV protection is disabled" -ForegroundColor Red
                $ioav = 2
            }
            elseif ((Get-MpPreference).DisableIOAVProtection -eq $false) {
                write-host "IOAV protection is enabled" -ForegroundColor Green
                $ioav = 1
            }
            else {
                write-host "IOAV protection is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableScriptScanning) {
                write-host "Script scanning is disabled" -ForegroundColor Red
                $script = 2
            }
            elseif ((Get-MpPreference).DisableScriptScanning -eq $false) {
                write-host "Script scanning is enabled" -ForegroundColor Green
                $script = 1
            }
            else {
                write-host "Script scanning is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableArchiveScanning) {
                write-host "Archive scanning is disabled" -ForegroundColor Red
                $archive = 2
            }
            elseif ((Get-MpPreference).DisableArchiveScanning -eq $false) {
                write-host "Archive scanning is enabled" -ForegroundColor Green
                $archive = 1
            }
            else {
                write-host "Archive scanning is unknown" -ForegroundColor Yellow
            }


            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableBlockAtFirstSeen) {
                write-host "Block at first seen is disabled" -ForegroundColor Red
                $block = 2
            }
            elseif ((Get-MpPreference).DisableBlockAtFirstSeen -eq $false) {
                write-host "Block at first seen is enabled" -ForegroundColor Green
                $block = 1
            }
            else {
                write-host "Block at first seen is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableAutoExclusions) {
                write-host "Auto exclusions is disabled" -ForegroundColor Red
                $auto = 2
            }
            elseif ((Get-MpPreference).DisableAutoExclusions -eq $false) {
                write-host "Auto exclusions is enabled" -ForegroundColor Green
                $auto = 1
            }
            else {
                write-host "Auto exclusions is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableRestorePoint) {
                write-host "Restore point is disabled" -ForegroundColor Red
                $restore = 2
            }
            elseif ((Get-MpPreference).DisableRestorePoint -eq $false) {
                write-host "Restore point is enabled" -ForegroundColor Green
                $restore = 1
            }
            else {
                write-host "Restore point is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"

            if ((Get-MpPreference).DisableRemovableDriveScanning) {
                write-host "Removable drive scanning is disabled" -ForegroundColor Red
                $removable = 2
            }
            elseif ((Get-MpPreference).DisableRemovableDriveScanning -eq $false) {
                write-host "Removable drive scanning is enabled" -ForegroundColor Green
                $removable = 1
            }
            else {
                write-host "Removable drive scanning is unknown" -ForegroundColor Yellow
            }

            write-host "----------------------------------------"


            # CHECK END
            # END ##################################################
            if ($defenderstatus -eq 1) {
                #MENU OPTION 1 (Realtime monitoring)
                write-host "1- Disable Windows Defender"
            }
            elseif ($defenderstatus -eq 2) {
                write-host "1- Enable Windows Defender"
            }
            else {
                write-host "Windows Defender Status Unknown" -ForegroundColor Yellow
            }

            if ($behavior -eq 1) {
                #MENU OPTION 2 (Behavior monitoring)
                write-host "2- Disable Behavior Monitoring"
            }
            elseif ($behavior -eq 2) {
                write-host "2- Enable Behavior Monitoring"
            }
            else {
                write-host "Behavior Monitoring Status Unknown" -ForegroundColor Yellow
            }

            if ($ioav -eq 1) {
                #MENU OPTION 3 (IOAV protection)
                write-host "3- Disable IOAV Protection"
            }
            elseif ($ioav -eq 2) {
                write-host "3- Enable IOAV Protection"
            }
            else {
                write-host "IOAV Protection Status Unknown" -ForegroundColor Yellow
            }

            if ($script -eq 1) {
                #MENU OPTION 4 (Script scanning)
                write-host "4- Disable Script Scanning"
            }
            elseif ($script -eq 2) {
                write-host "4- Enable Script Scanning"
            }
            else {
                write-host "Script Scanning Status Unknown" -ForegroundColor Yellow
            }

            if ($archive -eq 1) {
                #MENU OPTION 5 (Archive scanning)
                write-host "5- Disable Archive Scanning"
            }
            elseif ($archive -eq 2) {
                write-host "5- Enable Archive Scanning"
            }
            else {
                write-host "Archive Scanning Status Unknown" -ForegroundColor Yellow
            }


            if ($block -eq 1) {
                #MENU OPTION 6 (Block at first seen)
                write-host "6- Disable Block at First Seen"
            }
            elseif ($block -eq 2) {
                write-host "6- Enable Block at First Seen"
            }
            else {
                write-host "Block at First Seen Status Unknown" -ForegroundColor Yellow
            }

            if ($auto -eq 1) {
                #MENU OPTION 7 (Auto exclusions)
                write-host "7- Disable Auto Exclusions"
            }
            elseif ($auto -eq 2) {
                write-host "7- Enable Auto Exclusions"
            }
            else {
                write-host "Auto Exclusions Status Unknown" -ForegroundColor Yellow
            }

            if ($restore -eq 1) {
                #MENU OPTION 8 (Restore point)
                write-host "8- Disable Restore Point"
            }
            elseif ($restore -eq 2) {
                write-host "8- Enable Restore Point"
            }
            else {
                write-host "Restore Point Status Unknown" -ForegroundColor Yellow
            }

            if ($removable -eq 1) {
                #MENU OPTION 9 (Removable drive scanning)
                write-host "9- Disable Removable Drive Scanning"
            }
            elseif ($removable -eq 2) {
                write-host "9- Enable Removable Drive Scanning"
            }
            else {
                write-host "Removable Drive Scanning Status Unknown" -ForegroundColor Yellow
            }
            


            write-host ""
            write-host "[x] Back"

            $imput = Read-Host "Select an option"

            if ($imput -eq 1) {
                if ($defenderstatus -eq 1) {
                    Set-MpPreference -DisableRealtimeMonitoring $true
                    write-host "Windows Defender has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($defenderstatus -eq 2) {
                    Set-MpPreference -DisableRealtimeMonitoring $false
                    write-host "Windows Defender has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Windows Defender Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 2) {
                if ($behavior -eq 1) {
                    Set-MpPreference -DisableBehaviorMonitoring $true
                    write-host "Behavior Monitoring has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($behavior -eq 2) {
                    Set-MpPreference -DisableBehaviorMonitoring $false
                    write-host "Behavior Monitoring has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Behavior Monitoring Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 3) {
                if ($ioav -eq 1) {
                    Set-MpPreference -DisableIOAVProtection $true
                    write-host "IOAV Protection has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($ioav -eq 2) {
                    Set-MpPreference -DisableIOAVProtection $false
                    write-host "IOAV Protection has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "IOAV Protection Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 4) {
                if ($script -eq 1) {
                    Set-MpPreference -DisableScriptScanning $true
                    write-host "Script Scanning has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($script -eq 2) {
                    Set-MpPreference -DisableScriptScanning $false
                    write-host "Script Scanning has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Script Scanning Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 5) {
                if ($archive -eq 1) {
                    Set-MpPreference -DisableArchiveScanning $true
                    write-host "Archive Scanning has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($archive -eq 2) {
                    Set-MpPreference -DisableArchiveScanning $false
                    write-host "Archive Scanning has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Archive Scanning Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 6) {
                if ($block -eq 1) {
                    Set-MpPreference -DisableBlockAtFirstSeen $true
                    write-host "Block at First Seen has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($block -eq 2) {
                    Set-MpPreference -DisableBlockAtFirstSeen $false
                    write-host "Block at First Seen has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Block at First Seen Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 7) {
                if ($auto -eq 1) {
                    Set-MpPreference -DisableAutoExclusions $true
                    write-host "Auto Exclusions has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($auto -eq 2) {
                    Set-MpPreference -DisableAutoExclusions $false
                    write-host "Auto Exclusions has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Auto Exclusions Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 8) {
                if ($restore -eq 1) {
                    Set-MpPreference -DisableRestorePoint $true
                    write-host "Restore Point has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($restore -eq 2) {
                    Set-MpPreference -DisableRestorePoint $false
                    write-host "Restore Point has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Restore Point Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }
            elseif ($imput -eq 9) {
                if ($removable -eq 1) {
                    Set-MpPreference -DisableRemovableDriveScanning $true
                    write-host "Removable Drive Scanning has been disabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                elseif ($removable -eq 2) {
                    Set-MpPreference -DisableRemovableDriveScanning $false
                    write-host "Removable Drive Scanning has been enabled" -ForegroundColor Green
                    Start-Sleep 2
                }
                else {
                    write-host "Removable Drive Scanning Status Unknown" -ForegroundColor Yellow
                    Start-Sleep 2
                }
            }




            if ($imput -eq "x") {
                $whilelocura = $false
            }
        }
    }

    if ($choice -eq 3) {
        # CHOICE 3 #############################
        if (test-path -path "MpCmdRun.exe") {
            $whilethreat = $true
            while ($whilethreat) {
                clear-host
                write-host ""
                write-host "[1] Restore Individual Threat"
                write-host "[2] Restore All Threats"
                write-host ""
                write-host "[x] Back"
                $imput = Read-Host "Select an option"
                if ($imput -eq 1) {
                    write-host "----------------------------------------"
                    .\mpcmdrun.exe -Restore -ListAll
                    write-host "----------------------------------------"
                    $threatpath = Read-Host "Copy and paste threat path"
                    if (-not($threatpath)) {
                        write-warning "No threat path entered"
                        Start-Sleep 2
                    }
                    else {
                        .\mpcmdrun.exe -Restore -FilePath $threatpath
                        if ($?) {
                            write-host "Threat has been restored" -ForegroundColor Green
                            Start-Sleep 2
                        }
                        else {
                            write-warning "Threat could not be restored"
                            Start-Sleep 2
                        }
                    }

                }
                elseif ($imput -eq 2) {
                    write-host "----------------------------------------"
                    Write-Warning "This will restore all threats"
                    Write-Warning "This is insecure and should only be used in a controlled environment"
                    write-host "----------------------------------------"
                    $confirm = Read-Host "Are you sure you want to restore all threats? (restoreallthreats)"
                    if ($confirm -eq "restoreallthreats") {
                        .\mpcmdrun.exe -Restore -All
                        if ($?) {
                            write-host "All threats have been restored" -ForegroundColor Green
                            Start-Sleep 2
                        }
                        else {
                            write-warning "Threats could not be restored"
                            Start-Sleep 2
                        }
                    }
                    else {
                        write-warning "Aborting"
                        Start-Sleep 2
                    }
                }
                elseif ($imput -eq "x") {
                    $whilethreat = $false
                }
                else {
                    write-warning "Invalid option"
                    Start-Sleep 2
                }
            }
        }
        else {
            Write-Warning "MpCmdRun.exe not found"
            Start-Sleep -s 3
        }
    }

    if ($choice -eq 4) {
        # CHOICE 4 #############################
        write-host ""
        write-host "Updating definitions..."
        Start-Sleep 2
        Update-MpSignature
        if ($?) {
            write-host "Definitions have been updated" -ForegroundColor Green
            Start-Sleep 2
        }
        else {
            write-host "Something went wrong" -ForegroundColor Red
            Start-Sleep 2
        }
    }

    if ($choice -eq 5) {
        $whilescan = $true
        while ($whilescan) {
            clear-host
            Write-host ""
            write-host "Scan menu"
            write-host "1. Full Scan"
            write-host "2. Quick Scan"
            write-host "3. Scan a specific file"

            $scanchoice = Read-Host "Select an option or press [x] to exit"

            if ($scanchoice -eq 1) {
                Start-MpScan -ScanType QuickScan
                write-host ""
                write-host "Scan finished" -ForegroundColor Green
                pause
            }
            elseif ($scanchoice -eq 2) {
                Start-MpScan -ScanType FullScan
                write-host ""
                write-host "Scan finished" -ForegroundColor Green
                pause
            }
            elseif ($scanchoice -eq 3) {
                $file = Read-Host "Enter the file path"
                Start-MpScan -ScanType CustomScan -File $file
                write-host ""
                write-host "Scan finished" -ForegroundColor Green
                pause
            }

            if ($scanchoice -eq "x") {
                $whilescan = $false
            }




        }
    }





    if ($choice -eq "x") {
        $whdefendermanipulator = $false
    }

}
write-host "Exiting..." -ForegroundColor Cyan
Set-Location $HOME
Start-Sleep -s 1
exit