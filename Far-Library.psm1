Write-host "Far-Library cargado correctamente" -ForegroundColor Green
$farlibraryver = "0.3.3"
$script:architectureproc = (Get-WmiObject -Class Win32_ComputerSystem).SystemType

# En desarrollo ########################

function activarkms {
    param($mode)
    # Modos disponibles: classic, legacy, retail
    if($mode -eq "classic"){
        write-host "Comprobando estado de lidencia..."
        slmgr /xpr
        start-sleep -s 3
        Clear-Host
        write-host "Desactiva el Defender y otros antivirus antes de proceder"
        Pause
        if((Get-MpComputerStatus).BehaviorMonitorEnabled){
            Write-Warning "la proteccion contra alteraciones esta respondiendo"
            write-host "Desactiva manualmente la proteccion contra alteraciones antes de continuar"
            $continue = read-host "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                write-host "Abortando..."
                break
            }
        }
        if((Get-MpComputerStatus).RealTimeProtectionEnabled){
            Write-Warning "la proteccion en tiempo real esta respondiendo"
            write-host "Desactiva manualmente la proteccion en tiempo real antes de continuar"
            $continue = read-host "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                write-host "Abortando..."
                break
            }
        }
        write-host "Iniciando proceso de activacion..."
        if(test-path -path "cache\kms"){
            write-host "Eliminando archivos temporales..."
            remove-item -path cache/kms -recurse -force
            if(-not($?)){
                write-host "No se pudo eliminar la carpeta cache/kms"
                write-host "Abortando..."
                break
            }
            else{
                write-host "Carpeta cache/kms eliminada correctamente" -ForegroundColor Green
            }
        }
        if(test-path -path "C:\Programs Files\KMSpico"){
            Write-Warning "Instalacion anterior detectada"
            write-host "Eliminando instalacion anterior..."
            remove-item -path "C:\Programs Files\KMSpico" -recurse -force
            if(-not($?)){
                write-host "No se pudo eliminar la instalacion anterior, abortando..."
                break
            }
            else{
                write-host "Instalacion anterior eliminada correctamente" -ForegroundColor Green
            }
        }
        write-host "Descargando archivos necesarios..."
        mkdir cache\kms
        Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/activator/kms/KMSpico_setup.exe" -OutFile "cache/kms/KMSpico_setup.exe"
        if(-not($?)){
            write-host "Error al descargar KMSpico_setup.exe" -ForegroundColor Red
            write-host "Descarguelo manualmente"
            write-host "https://github.com/contratop/Sources/raw/main/far_data/activator/kms/KMSpico_setup.exe"
            $continue = read-host "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                write-host "Abortando..."
                break
            }
        }
        write-host "Ejecutando KMSpico_setup.exe"
        start-process -filepath "cache/kms/KMSpico_setup.exe" -Wait
        if(-not($?)){
            Write-Warning "Excepcion en KMSpico_setup.exe"
            $continue = read-host "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                write-host "Abortando..."
                break
            }
        }
        $null = read-host "BAJA EL VOLUMEN y presiona enter para continuar"
        write-host "Activando Windows..."
        start-process -filepath "C:\Programs Files\KMSpico\KMSELDI.exe" -Wait
        if(-not($?)){
            Write-Warning "Excepcion en KMSELDI.exe"
            $continue = read-host "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                write-host "Abortando..."
                break
            }
        }
        else{
            write-host "Windows activado correctamente" -ForegroundColor Green
        }
    }

    elseif($mode -eq "legacy"){
        write-host "[1] Activacion Original"
        write-host "[2] Activacion Unofficial"
        $option = read-host "Escribe el numero de la opcion que deseas"
        if($option -eq 1){
            $key = read-host "Escribe la clave de licencia original de WIndows"
            slmgr /ipk $key
            if(-not($?)){
                write-host "Error al ingresar la clave de licencia" -ForegroundColor Red
                write-host "Abortando..."
                break
            }
            else{
                write-host "Clave de licencia ingresada correctamente" -ForegroundColor Green
                write-host "Windows activado" -ForegroundColor Green
            }
        }
        elseif($option -eq 2){
            $wh1 = $true
            while($wh1){
            write-host "[1] Activar Windows 10 Pro"
            write-host "[2] Activar Windows 10 Home/Educationº"
            write-host "[3] Activar Windows 10 Enterprise"
            $option = read-host "Escribe el numero de la opcion que deseas"
            if($option -eq 1){
                clear-host
                write-host "[1] Windows 10 Pro 1"
                write-host "[2] Windows 10 Pro 2"
                write-host "[3] Windows 10 Pro Education"
                write-host "[4] Windows 10 Pro Education N"
                write-host "[5] Windows 10 Pro N"
                write-host "[6] Windows 10 Pro N 2"
                write-host "[7] Windows 10 Pro Serial"
                $selection = read-host "Escribe el numero de la opcion que deseas"
                if($selection -eq 1){
                    write-host "Activando Windows 10 Pro 1"
                    slmgr /ipk VK7JG-NPHTM-C97JM-9MPGT-3V66T
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green

                }
                elseif($selection -eq 2){
                    write-host "Activando Windows 10 Pro 2"
                    slmgr /ipk NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 3){
                    write-host "Activando Windows 10 Pro Education"
                    slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 4){
                    write-host "Activando Windows 10 Pro Education N"
                    slmgr /ipk YVWGF-BXNMC-HTQYQ-CPQ99-66QFC
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 5){
                    write-host "Activando Windows 10 Pro N"
                    slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 6){
                    write-host "Activando Windows 10 Pro N 2"
                    slmgr /ipk 9FNHH-K3HBT-3W4TD-6383H-6XYWF
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 7){
                    write-host "Activando Windows 10 Pro Serial"
                    slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                else{
                    write-host "Opcion invalida" -ForegroundColor Red
                        write-host "Abortando..."
                        break
                    }
                }

            elseif($option -eq 2){
                Clear-Host
                write-host "[1] Windows 10 Home"
                write-host "[2] Windows 10 Home Single Language"
                write-host "[3] Windows 10 Education"
                write-host "[4] Windows 10 Education N"
                $selection = read-host "Escribe el numero de la opcion que deseas"
                if($selection -eq 1){
                    write-host "Activando Windows 10 Home"
                    slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 2){
                    write-host "Activando Windows 10 Home Single Language"
                    slmgr /ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 3){
                    write-host "Activando Windows 10 Education"
                    slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 4){
                    write-host "Activando Windows 10 Education N"
                    slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                else{
                    write-host "Opcion invalida" -ForegroundColor Red
                        write-host "Abortando..."
                        break
                    }
                }

            
            elseif($option -eq 3){
                Clear-Host
                write-host "[1] Windows 10 Enterprise"
                write-host "[2] Windows 10 Enterprise 2"
                write-host "[3] Windows 10 Enterprise G"
                write-host "[4] Windows 10 Enterprise G N"
                write-host "[5] Windows 10 Enterprise N"
                $selection = read-host "Escribe el numero de la opcion que deseas"
                if($selection -eq 1){
                    write-host "Activando Windows 10 Enterprise"
                    slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 2){
                    write-host "Activando Windows 10 Enterprise 2"
                    slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 3){
                    write-host "Activando Windows 10 Enterprise G"
                    slmgr /ipk YYVX9-NTFWV-6MDM3-9PT4T-4M68B
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 4){
                    write-host "Activando Windows 10 Enterprise G N"
                    slmgr /ipk 44RPN-FTY23-9VTTB-MP9BX-T84FV
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                elseif($selection -eq 5){
                    write-host "Activando Windows 10 Enterprise N"
                    slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
                    write-host "Cambiando host de licencia"
                    slmgr /skms kms.msguides.com
                    write-host "Activando Windows"
                    slmgr /ato
                    write-host "Script finalizado" -ForegroundColor Green
                }
                else{
                    write-host "Opcion invalida" -ForegroundColor Red
                        write-host "Abortando..."
                        break
                    }
                }

            else{
                Write-Warning "Opcion invalida"
                Start-Sleep -s 2
            }
        }
         }

     }
    
    elseif($mode -eq "keys"){
        if(test-path -path "cache\activation"){
            write-host "Limpiando cache de activacion"
            remove-item -path "cache\activation" -recurse -Force
            if(-not($?)){
                write-host "Error al limpiar la cache de activacion" -ForegroundColor Red
                write-host "Abortando..."
                break
            }
            else{
                write-host "Cache de activacion limpiada correctamente" -ForegroundColor Green
            }
        }
        write-host "Descargando software de activacion Retail"
        mkdir cache\activation
        Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/activator/winloader/Keys.ini" -OutFile "cache\activation\Keys.ini"
        if(-not($?)){
            Write-Warning "Error al descargar las Keys"
            $continue = "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                Write-Warning "Abortando..."
                break
            }
        }
        else{
            write-host "Keys descargado correctamente" -ForegroundColor Green
        }
        write-host "Descargando software de activacion..."
        Invoke-WebRequest -uri "https://github.com/contratop/Sources/raw/main/far_data/activator/winloader/Windows%20Loader.exe" -OutFile "cache\activation\windowsloader.exe"
        if(-not($?)){
            Write-Warning "Error al descargar el activador"
            $continue = "Escribe [continue] para continuar"
            if(-not($continue -eq "continue")){
                Write-Warning "Abortando..."
                break
            }
        }
        else{
            write-host "Activador descargado correctamente" -ForegroundColor Green
        }
        write-host "Ejecutando activador..."
        start-process -filepath "cache\activation\windowsloader.exe" -Wait
        Pause
        write-host "Script finalizado" -ForegroundColor Green


    }
    else{
        write-host "Parametro invalido" -ForegroundColor Red
        write-host "Contacte al desarrollador"
    }
}

# En desarrollo ########################



# En Desarrollo ########################



































function individualrepair{
    $whilelib1 = $true
    while($whilelib1){
        Clear-Host
        write-host "Far-Resolver Individual Repair"
        write-host "-------------------------------------------"
        write-host ""
        write-host "Menu Individual"
        write-host ""
        write-host "[1] Winget Check"
        write-host "[2] Windows Defender Check"
        write-host "[3] DISM / SFC Check"
        write-host "[4] MRT"
        write-host "[5] SigVerif"
        write-host "[6] perfmon"
        write-host "[7] CHKDSK"
        write-host ""
        write-host "[x] Volver"
        $menuoption = read-host "Selecciona una opcion"
        switch($menuoption){
            1{# OPCION 1 INDIVID ####
                write-host ""
                write-host "Checking winget..."
                if(-not(Get-Command winget -ErrorAction SilentlyContinue)){
                    write-warning "No se ha detectado Winget o no esta funcionando correctamente"
                    write-host "Reparando Winget... (Invoke wingetupgrade)"
                    wingetupgrade
                    write-host "Operacion completada" -ForegroundColor Cyan
                    pause
                }
                elseif(Get-Command winget -ErrorAction SilentlyContinue){
                    write-host "Winget esta funcionando correctamnete" -ForegroundColor Green
                    Start-Sleep -s 3
                }
                else{
                    Write-Warning "Excepcion no controlada (desbordamiento de codigo)"
                    pause
                }
                #################################
            }
            2{
                write-host ""
                Write-host "Checking Windows Defender..."
                if(-not(Get-Command Get-MpComputerStatus -ErrorAction SilentlyContinue)){
                    Write-Warning "No se puede tener acceso a Windows Defender"
                    Pause
                }
                else{
                    if((Get-MpComputerStatus).AntivirusEnabled){
                        write-host "Servicio antivirus funcionando correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-Warning "Servicio antivirus no responde"
                    }
                    if((Get-MpComputerStatus).AntiSpywareEnabled){
                        Write-host "Servicio antispyware funcionando correcatamente" -ForegroundColor Green
                    }
                    else{
                        Write-Warning "Servicio antispyware no responde"
                    }
                    if((Get-MpComputerStatus).AntispywareEnabled){
                        Write-host "Servicio AntiSpyware funcionando correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-Warning "Servicio AntiSpyware no responde"
                    }
                    if((Get-MpComputerStatus).BehaviorMonitorEnabled){
                        Write-host "Servicio de proteccion contra alteraciones funcionando correctamente" -ForegroundColor Green
                    }
                    else{
                        Write-Warning "Servicio de proteccion contra alteraciones no responde"
                    }
                }
                Write-host "Operacion completada" -ForegroundColor Green
                pause

            }
            3{
                write-host ""
                write-host "DISM / SFC Checking..."
                write-host "Reparando integridad dle sistema (1/4)"
                # Unificado de momento #
                DISM /Online /Cleanup-Image /CheckHealth
                DISM /Online /Cleanup-Image /ScanHealth
                DISM /Online /Cleanup-Image /RestoreHealth
                sfc /scannow
                write-host "Operacion completada" -ForegroundColor Green
                pause
            }
            4{
                Write-host ""
                write-host "Ejecutando MRT..."
                Start-Process mrt.exe
                write-host "Operacion completada" -ForegroundColor Green
                Pause
            }
            5{
                Write-host ""
                write-host "Ejecutando SigVerif"
                Start-Process sigverif.exe
                write-host "Operacion completada" -ForegroundColor Green
                pause
            }
            6{
                write-host ""
                write-host "Ejecutando Perfmon"
                Start-Process perfmon.exe /rel
                write-host "Operacion completada" -ForegroundColor Green
                pause
            }
            7{
                write-host ""
                write-host "El analisis de disco CHKDSK requiere reinicio del sistema"
                write-host "Prodeciendo en 10 segundos"
                write-host "para abortar, CTRL + C"
                Start-Sleep -s 10
                write-host "Realizando analisis de disco C:"
                chkdsk c: /f /r /x
                write-host "Operacion completada"
                pause
            }



            x{
                Clear-Host
                $whilelib1 = $false
            }


            ####### DEFAULT ZONE ##########
            default{
                Write-Warning "Opcion no valida"
                start-sleep -s 2
            }
        }
    }
}
























function FarLibraryVersion{# FAR LIBRARY VERSION PRINT ###########################################################
    Write-host "Far-Library Version $farlibraryver" -ForegroundColor Green
}




function windowsrepair{# WINDOWS REPAIRER ###################################################################
    write-host "Windows Repairer" -ForegroundColor Blue
    write-host "------------------------------"
    write-host ""
    write-host "Registrando eventos en Far-Resolver-log.txt"
    "Far-Resolver Registro de reparacion" >> Far-Resolver-log.txt # LOG
    ################ FASE 1 (WingetCheck) #################
    write-host "Comprobando Winget"
    if(-not(Get-Command winget -ErrorAction SilentlyContinue)){
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
    if(-not(Get-Command Get-MpComputerStatus -ErrorAction SilentlyContinue)){
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
            $defendererrors = $defendererrors + 1
        }
        if((Get-MpComputerStatus).AntispywareEnabled){
            write-host "Get-MpComputerStatus.AntiSpywareEnabled =" ((Get-MpComputerStatus).AntispywareEnabled) >> Far-Resolver-log.txt # LOG
            Write-host "El servico AntiSpyware esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.AntiSpywareEnabled =" ((Get-MpComputerStatus).AntiSpywareEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio AntiSpyware no responde"
            $defendererrors = $defendererrors + 1
        }
        if((Get-MpComputerStatus).BehaviorMonitorEnabled){
            write-host "Get-MpComputerStatus.BehaviorMonitorEnabled =" ((Get-MpComputerStatus).BehaviorMonitorEnabled) >> Far-Resolver-log.txt # LOG
            write-host "El servicio de proteccion contra alteraciones esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.BehaviorMonitorEnabled =" ((Get-MpComputerStatus).BehaviorMonitorEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio de proteccion contra alteraciones no esta respondiendo"
            $defendererrors = $defendererrors + 1
        }
        if((Get-MpComputerStatus).RealTimeProtectionEnabled){
            write-host "Get-MpComputerStatus.RealTimeProtectionEnabled =" ((Get-MpComputerStatus).RealTimeProtectionEnabled) >> Far-Resolver-log.txt # LOG
            Write-host "El servicio de proteccion a tiempo real esta respondiendo" -ForegroundColor Green
        }
        else{
            write-host "EXCEPTION: Get-MpComputerStatus.RealTimeProtectionEnabled =" ((Get-MpComputerStatus).RealTimeProtectionEnabled) >> Far-Resolver-log.txt # LOG
            Write-Warning "El servicio de proteccion a tiempo real no esta respondiendo"
            $defendererrors = $defendererrors + 1
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
    if(-not(Get-Command dism -ErrorAction SilentlyContinue)){
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
            $integrityerror = $integrityerror + 1
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
            $integrityerror = $integrityerror + 1
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
            $integrityerror = $integrityerror + 1
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
            $integrityerror = $integrityerror + 1
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
    if(Get-Command MRT -ErrorAction SilentlyContinue){
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
    ##### FASE 7 (chkdsk) #########
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
            Remove-Item marcos64.Appx
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
            Remove-Item mui64.appx
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
            Remove-Item marcos86.Appx
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
            Remove-Item mui86.appx
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
        Remove-Item winget.Msixbundle
    }
    ""
    pause
}












# Export Data

Export-ModuleMember -Variable * -Function *