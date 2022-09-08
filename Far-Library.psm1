Write-host "Far-Library cargado correctamente" -ForegroundColor Green
$farlibraryver = "0.2"










function FarLibraryVersion{# FAR LIBRARY VERSION PRINT ###########################################################
    Write-host "Far-Library Version $farlibraryver" -ForegroundColor Green
}




function windowsrepair{
    write-host "Windows Repairer" -ForegroundColor Blue
    write-host "------------------------------"
    write-host ""
    write-host "Registrando enventos en Far-Resolver-log.txt"
    "Far-Resolver Registro de reparacion" >> Far-Resolver-log.txt # LOG
    ################ FASE 1 (WingetCheck) #################
    write-host "Comprobando Winget"
    if(-not(Get-Command winget)){
        "Winget no esta presente en el sistema y se procede a ejecutar wingetupgrade" >> Far-Resolver-log.txt # LOG
        Write-Warning "Winget no esta disponible o presenta problemas"
        Write-host "Ejecutando Winget Upgrade de Far-Library..."
        wingetupgrade
        if($?){
            "Instalacion/Reinstalacion de Winget completada con exito" >> Far-Resolver-log.txt # LOG
            write-host "Reparacion de Winget finalizada" -ForegroundColor Green
        }
        else{
            "Ha ocurrido una excepcion en la funcion wingetupgrade" >> Far-Resolver-log.txt # LOG
            Write-Warning "wingetupgrade ha devulevo codigo de salida con errores"
        }
    }
    else{
        "Winget esta presente en el sistema" >> Far-Resolver-log.txt # LOG
    }
    ############ FASE 2  (DefenderCheck) ############
    ""
    "" >> Far-Resolver-log.txt # LOG
    Write-host "Comprobando estado de Windows defender..."
    "Comprobacion de estado de Windows Defender" >> Far-Resolver-log.txt # LOG
    if(-not(Get-Command Get-MpComputerStatus)){
        "No existe el comando Get-MpComputerStatus" >> Far-Resolver-log.txt # LOG
        Write-Warning "No se tiene acceso al estado de Windows Defender"
        Start-Sleep -s 5
    }
    else{
        $script:defendererrors = 0
        "Get-MpComputerStatus Responde correctamente, incializado comprobacion de parametros" >> Far-Resolver-log.txt # LOG
        if((Get-MpComputerStatus).AntivirusEnabled){
            write-host "Get-MpComputerStatus.AntivirusEnabled =" ((Get-MpComputerStatus).AntivirusEnabled) >> Far-Resolver-log.txt # LOG
            write-host "El servicio antivirus esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.AntivirusEnabled =" ((Get-MpComputerStatus).AntivirusEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio antivirus no responde"
            $defendererrors =+ 1
        }
        if((Get-MpComputerStatus).AntispywareEnabled){
            write-host "Get-MpComputerStatus.AntiSpywareEnabled =" ((Get-MpComputerStatus).AntispywareEnabled) >> Far-Resolver-log.txt # LOG
            Write-host "El servico AntiSpyware esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.AntiSpywareEnabled =" ((Get-MpComputerStatus).AntiSpywareEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio AntiSpyware no responde"
            $defendererrors =+ 1
        }
        if((Get-MpComputerStatus).BehaviorMonitorEnabled){
            write-host "Get-MpComputerStatus.BehaviorMonitorEnabled =" ((Get-MpComputerStatus).BehaviorMonitorEnabled) >> Far-Resolver-log.txt # LOG
            write-host "El servicio de proteccion contra alteraciones esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.BehaviorMonitorEnabled =" ((Get-MpComputerStatus).BehaviorMonitorEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio de proteccion contra alteraciones no esta respondiendo"
            $defendererrors =+ 1
        }
        if((Get-MpComputerStatus).RealTimeProtectionEnabled){
            write-host "Get-MpComputerStatus.RealTimeProtectionEnabled =" ((Get-MpComputerStatus).RealTimeProtectionEnabled) >> Far-Resolver-log.txt # LOG
            Write-host "El servicio de proteccion a tiempo real esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.RealTimeProtectionEnabled =" ((Get-MpComputerStatus).RealTimeProtectionEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio de proteccion a tiempo real no esta respondiendo"
            $defendererrors =+ 1
        }
        if($defendererrors -eq 0){
            "defendererrors = 0" >> Far-Resolver-log.txt # LOG
            Write-Host "Windows defender esta funcionando correctamente" -ForegroundColor Green
        }
        else{
            write-host "Defender Errors: $defendererrors" >> Far-Resolver-log.txt # LOG
            Write-Warning "Windows Defender no esta funcionando correctamente"
            write-host "Se ha guardado los detalles en Far-Resolver-Log para su reparacion manual"
        }  
    }
    ""
    "" >> Far-Resolver-log.txt # LOG
    ######### FASE 3 (Escaneo DISM y SFC) ################
    if(-not(Get-Command dism)){
        "dism command not found" >> Far-Resolver-log.txt # LOG
        Write-Warning "Dism no esta disponible en este sistema"
    }
    else{
        $script:integrityerror = 0
        # reparacion fase 1 #
        Write-host "Reparando integridad del sistema (fase 1/4)"
        "executing: DISM /Online /Cleanup-Image /CheckHealth" >> Far-Resolver-log.txt # LOG
        DISM /Online /Cleanup-Image /CheckHealth
        if($?){
            "dism checkhealth exit code: 0" >> Far-Resolver-log.txt # LOG
            Write-host "Fase 1 completada" -ForegroundColor Green
        }
        else{
            "dism checkhealth exception exit code" >> Far-Resolver-log.txt # LOG
            Write-Warning "Error o anomalia en la fase 1. continuando..."
            $integrityerror =+ 1
        }
        # Reparacion fase 2 #
        Write-host "Reparando integridad del sistema (fase 2/4)"
        "executing: DISM /Online /Cleanup-Image /ScanHealth" >> Far-Resolver-log.txt # LOG
        DISM /Online /Cleanup-Image /ScanHealth
        if($?){
            "dism scanhealth exit code 0" >> Far-Resolver-log.txt # LOG
            Write-host "Fase 2 completada"
        }
        else{
            "dirm scanhealth exception exit code" >> Far-Resolver-log.txt # LOG
            Write-Host "Error o anomalia en la fase 2. continuando..."
            $integrityerror =+ 1
        }
        # Reparacion fase 3 #
        Write-host "Reparando integridad del sistema (fase 3/4)"
        "executing: DISM /Online /Cleanup-Image /RestoreHealth" >> Far-Resolver-log.txt # LOG
        DISM /Online /Cleanup-Image /RestoreHealth
        if($?){
            "dism RestoreHealth exit code 0" >> Far-Resolver-log.txt # LOG
            Write-host "Fase 3 completada"
        }
        else{
            "dirm RestoreHealth exception exit code" >> Far-Resolver-log.txt # LOG
            Write-Host "Error o anomalia en la fase 3. continuando..."
            $integrityerror =+ 1
        } 
        # Reparacion fase 4 #
        Write-host "Reparando integridad del sistema (fase 4/4)"
        "executing: sfc /scannow" >> Far-Resolver-log.txt # LOG
        sfc /scannow
        if($?){
            "sfc exit code: 0" >> Far-Resolver-log.txt # LOG
            Write-host "Fase 4 completada"
        }
        else{
            "sfc exception exit code" >> Far-Resolver-log.txt # LOG
            Write-Warning "Error o anomalia en la fase 4"
            $integrityerror =+ 1
        }
    }
    if($integrityerror -eq 0){
        "SUCCESS: integrity errors: 0" >> Far-Resolver-log.txt # LOG
        Write-host "Reparacion de integridad del sistema finalizada" -ForegroundColor Green
    }
    else{
        write-host "WARN: Integrity error: $integrityerror" >> Far-Resolver-log.txt # LOG
        Write-Warning "Errores de ejecuccion de integridad del sistema: $integrityerror"
        write-host "Se ha registrado los errores en Far-Resolver-log.txt"
        pause
    }
    ""
    "" >> Far-Resolver-log.txt # LOG
    ############# FASE 4 (MRT) ################
    if(Get-Command MRT.exe){
        write-host "Comprobado anomalias en las definiciones estandar de Windows..."
        "executing: start-process mrt.exe -wait" >> Far-Resolver-log.txt # LOG
        Start-Process mrt.exe -Wait
        if($?){
            "mrt exit code 0" >> Far-Resolver-log.txt # LOG
            Write-Host "Operacion completada" -ForegroundColor Green
            pause
        }
        else{
            "mrt exception" >> Far-Resolver-log.txt # LOG
            Write-Warning "Excepcion ocurrida en MRT"
            pause
        }
    }
    else{
        Write-Warning "MRT no esta disponible"
    }
    ""
    "" >> Far-Resolver-log.txt # LOG
    ################ FASE 5 (sigverif) ####################
    write-host "Comprobando firma de controladores..."
    "executing: start-process sigverif.exe -Wait" >> Far-Resolver-log.txt # LOG
    Start-Process sigverif.exe -Wait
    if($?){
        "sigverif exit code 0" >> Far-Resolver-log.txt # LOG
        Write-Host "Operacion completada" -ForegroundColor Green
        pause
    }
    else{
        "sigverif exception" >> Far-Resolver-log.txt # LOG
        Write-Warning "Excepcion ocurrida en sigverif"
        pause
    }
    ""
    "" >> Far-Resolver-log.txt # LOG
    ################ FASE 6 (perfmon) #######################
    write-host "Abriendo monitor de confiabilidad (Operacion manual)"
    "executing: start-process perfom /rel -wait" >> Far-Resolver-log.txt # LOG
    Start-Process permon /rel -Wait
    if($?){
        "perfmon exit code 0" >> Far-Resolver-log.txt # LOG
        Write-host "Operacion completada" -ForegroundColor Green
        pause
    }
    else {
        "perfmon exception" >> Far-Resolver-log.txt # LOG
        Write-Warning "Exception en perfmon"
        pause
    }
    ""
    "" >> Far-Resolver-log.txt # LOG
    "prompt for chkdsk" >> Far-Resolver-log.txt # LOG
    write-host "Deseas reparar ahora la unidad de disco C:?"
    write-host "Esta operacion requiere el reincio del sistema"
    $diskconfirmrepair = read-host "para proceder, escribe [continue]"
    if($diskconfirmrepair -eq "continue"){
        "check confirmed" >> Far-Resolver-log.txt # LOG
        chkdsk c: /f /r /x
        if($?){
            "chkdsk exit code 0" >> Far-Resolver-log.txt # LOG
            Write-host "Operacion completada"
        }
        else{
            "chkdsk exception" >> Far-Resolver-log.txt # LOG
            Write-Warning "Excepcion en chkdsk (Puede ser falso positivo de Far-Resolver"
        }
    }
    else{
        "chkdsk skipped" >> Far-Resolver-log.txt # LOG
        Write-warning "Comprobacion de disco omitida"
        Start-Sleep -s 4
    }
    "Windows repair finished (EndLine)" >> Far-Resolver-log.txt # LOG
    Write-host "Windows Repair ha finalizado"
}

















function wingetupgrade{# WINGET UPDATE (From Base) ################################################################
    if(Get-Command winget -ErrorAction SilentlyContinue){
        write-host "Winget esta funcionando correctamente"
    }
    else{
        Write-Warning "No se ha detectado Winget"
        write-host "Se va a proceder a instalar Winget..."
        write-host ""
        Start-Sleep -s 2
        write-host "Arquitectura $architectureproc"
        write-host "Instalando marcos.."
        Start-Sleep -s 2
        if($architectureproc -match "64"){
            if(-not(test-path -path "marcos64.Appx")){
                write-host "Descargando marcos64.Appx..."
                Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/marcos64.Appx" -OutFile "marcos64.Appx"
                if(-not($?)){
                    Write-Warning "Error en la descarga"
                    Write-host "Instalando Winget de todas formas"
                }
                else{
                    Add-AppPackage "marcos64.Appx"
                    if($?){
                        write-host "Marcos x64 instalados correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-host "Error al instalar marcos" -ForegroundColor Yellow
                        write-host "Se intentara instalar Winget de todas formas"
                        Start-Sleep -s 5
                    }
                }
            }
            elseif(Test-Path -path "marcos64.Appx"){
                Add-AppPackage "marcos64.Appx"
                if($?){
                    write-host "Marcos x64 instalados correctamente" -ForegroundColor Green
                }
                else{
                    Write-host "Error al instalar marcos" -ForegroundColor Yellow
                    write-host "Se intentara instalar Winget de todas formas"
                    Start-Sleep -s 5
                }
            }
            if(-not(test-path -path "mui64.appx")){
                Write-host "Descargando mui64.appx..."
                Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/mui64.Appx" -OutFile "mui64.appx"
                if(-not($?)){
                    Write-Warning "Error en la descarga"
                    Write-host "Instalando Winget de todas formas"
                }
                else {
                    Add-AppPackage "mui64.appx"
                    if($?){
                        write-host "Mui64 Instalado Correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-Warning "Error al instalar Mui" 
                        Write-host "Se intentara instalar Winget de todas formas"
                        Start-Sleep -s 5
                    }
                }
            }
            elseif(Test-Path -path "mui64.appx"){
                Add-AppxPackage "mui64.appx"
                if($?){
                    write-host "Mui64 Instalador Correctamente" -ForegroundColor Green
                }
                else{
                    Write-host "Error al instalar Mui" -ForegroundColor Yellow
                    Write-host "Se intentara instalar Winget de todas formas"
                    Start-Sleep -s 5
                }
            }
        }
        else{
            if(-not(test-path -path "marcos86.Appx")){
                write-host "Descargando marcos86.Appx..."
                Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/marcos86.Appx" -OutFile "marcos86.Appx"
                if(-not($?)){
                    Write-Warning "Error al descargar"
                    Write-host "Instalando Winget de todas formas"
                }
                else{
                    Add-AppPackage "marcos86.Appx"
                    if($?){
                        write-host "Marcos x86 instalados correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-host "Error al instalar marcos" -ForegroundColor Yellow
                        write-host "Se intentara instalar Winget de todas formas"
                        Start-Sleep -s 5
                    }
                }
            }
            elseif(test-path -path "marcos86.Appx"){
                Add-AppPackage "marcos86.Appx"
                if($?){
                    write-host "Marcos x86 instalados correctamente" -ForegroundColor Green
                }
                else{
                    Write-host "Error al instalar marcos" -ForegroundColor Yellow
                    write-host "Se intentara instalar Winget de todas formas"
                    Start-Sleep -s 5
                }
            }
            if(-not(test-path -path "mui86.appx")){
                Write-host "Descargando mui86.appx"
                Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/mui86.appx" -OutFile "mui86.appx"
                if(-not($?)){
                    Write-host "Error en la descarga"
                    Write-host "Instalando Winget de todas formas"
                }
                else{
                    Add-AppPackage "mui86.appx"
                    if($?){
                        write-host "Mui86 instalado correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-Warning "Error al instalar Mui"
                        Write-Host "Se intentara instalar Winget de todas formas"
                        start-sleep -s 5
                    }
                }
            }
            elseif(test-path -path "mui86-appx"){
                Add-AppPackage "mui86.appx"
                if($?){
                    write-host "Mui86 instalado correctamente" -ForegroundColor Green
                }
                else{
                    Write-Warning "Error al instalar Mui"
                    Write-Host "Se intentara instalar Winget de todas formas"
                    start-sleep -s 5
                }
            }
        }
        write-host ""
        if(-not(test-path -path "winget.Msixbundle")){
            write-host "Descargando Winget..."
            Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/winget.Msixbundle" -OutFile "winget.Msixbundle"
            if($?){
                Write-Host "Instalando Winget..."
                Add-AppPackage "winget.Msixbundle"
                if($?){
                    Write-host "Instalacion de Winget completada correctamente" -ForegroundColor Green
                }
                else{
                    Write-Warning "La instalacion de winget ha fallado"
                }
            }
            else{
                Write-Warning "Error al descargar Winget"
            }
        }
        elseif(test-path -path "winget.Msixbundle"){
            Write-Host "Instalando Winget..."
            Add-AppPackage "winget.Msixbundle"
            if($?){
                Write-host "Instalacion de Winget completada correctamente" -ForegroundColor Green
            }
            else{
                Write-Warning "La instalacion de winget ha fallado"
            }
        }
    }
    ""
    pause
}












# Export Data

Export-ModuleMember -Variable * -Function *