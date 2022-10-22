try {
    #Far Resolver 1.0 (test commit)
    # Header  ##########################
    Remove-Module Far-Library
    Clear-Host
    $ver = "0.7"
    $Host.UI.RawUI.WindowTitle = "Far Resolver Ver. $ver"
    
    
    # Parse Check #######################
    $script:OSVersion = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
    $script:architectureproc = (Get-WmiObject -Class Win32_ComputerSystem).SystemType
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
        Write-Host "You didn't run FAR-Resolver as an Administrator. FAR-Resolver will self elevate to run as an Administrator and continue."
        Start-Sleep 1
        Write-Host "                                               3"
        Start-Sleep 1
        Write-Host "                                               2"
        Start-Sleep 1
        Write-Host "                                               1"
        Start-Sleep 1
        Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
        Exit
    }
    
    
    $errorcounter = 0
    write-host "Far-Resolver Integrity Check:"
    $elevated = ([Security.Principal.WindowsPrincipal] `
            [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if ($elevated -eq $true) {
        write-host "Elevated: Yes" -ForegroundColor Green
    }
    else {
        write-warning "Elevated: No"
        $errorcounter++
    }
    
    
    
    
    
    if (-not(test-path -path "Far-Library.psm1")) {
        Write-Warning "Falta Far-Library"
        Write-host "Descargando..."
        Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "Far-Library.psm1"
        if ($?) {
            Import-Module .\Far-Library.psm1
        }
        else {
            Write-Warning "Ha ocurrido un error al descargar Far-Library"
            Write-host "Descarguelo manualmente"
            write-host "https://github.com/contratop/Far-Resolver/blob/main/Far-Library.psm1"
            Write-Warning "El modulo Far-Library no ha cargado"
            $errorcounter++
        }
    }
    else {
        Import-Module .\Far-Library.psm1
        if (-not($?)) {
            Write-Warning "El modulo Far-Library no ha cargado"
            $errorcounter++
        }
    }
    
    
    
    if (-not($OSVersion -match "Windows")) {
        # Check OS
        Write-host "Sistema Operativo $OSVersion"
        Write-Warning "No se detecta O.S Windows"
        $errorcounter++
    }
    else {
        Write-host "Sistema Operativo $OSVersion"
        Write-host "O.S OK" -ForegroundColor Green
    }
    ""
    if (-not($architectureproc -match "64")) {
        # Check Bits
        Write-host "Arquitectura CPU: $architectureproc"
        Write-Warning "64 Bits CPU Not detected"
        $errorcounter++
    }
    else {
        Write-host "Arquitectuta CPU: $architectureproc"
        Write-host "64 Bits OK" -ForegroundColor Green
    }
    ""
    
    
    
    # Directory Parse ################################
    if (-not(test-path -path plugins)) {
        # Check Plugins Dir
        Write-Warning "Plugins Folder not found"
    }
    else {
        $countps1 = Get-ChildItem plugins\*.ps1 -Recurse -File | Measure-Object | Select-Object Count
        write-host "Plugins: " $countps1.count
        Write-Host "Plugins OK" -ForegroundColor Green
    }
    ""
    
    
    
    # Command Parse #####################################
    if (-not(Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Warning "Git not installed"
        $errorcounter++
    }
    else {
        Write-host "Git OK" -ForegroundColor Green
    }
    ""
    if (-not(Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Warning "Winget not detected"
        $errorcounter++
    }
    else {
        write-host "Winget OK" -ForegroundColor Green
    }
    ""
    write-host "Powershell Version: " (($PSVersionTable).PSVersion)
    
    
    
    # Stop si detecta porlomenos 1 error, para depurar errores
    Write-host ""
    if (-not($errorcounter -eq 0)) {
        Write-Warning "Errores detectados: $errorcounter"
        Write-Warning "Hay errores de integridad, funcionalidad limitada"
        write-host ""
        $continue = read-host "Proceder de todos modos? NO RECOMENDABLE [continue]"
        if (-not($continue -eq "continue")) {
            Write-Warning "Ejecuccion cancelada"
            exit
        }
    }
    else {
        pause
    }
    
    
    
    
    
    
    
    
    
    
    
    
    # MENU PRINCIPAL #####################################
    
    $while1 = $true
    while ($while1) {
        clear-host
        Write-host "Far-Resolver Console Version $ver"
        if (-not(Get-Module Far-Library)) { Write-Warning "Modulo Far-Library no cargado" }
        else { FarLibraryVersion }
        if (-not($errorcounter -eq 0)) { Write-Warning "Ejecutandose con errores de integridad" }
        if ($gettedGUI) { Write-host "Ultimo plugin ejecutado: $gettedGUI" }
        write-host ""
        # Plugins Data Check & Print Data
        if (test-path -path plugins) {
            if ($countps1.count -eq 0) {
                Write-Host "No hay plugins disponibles" -ForegroundColor Yellow
                $pluginsenable = 0
            }
            else {
                write-host "Plugins PS1:" $countps1.count "plugins detectados" -ForegroundColor Magenta
            }
        }
        elseif (-not(Test-Path -path plugins)) {
            Write-Warning "No se encuentra la carpeta de plugins"
        }
        else {
            Write-Warning "Excepcion no controlada al detectar la carpeta de plugins"
        }
    
        write-host ""
        Write-host "Far-Resolver Main Menu" # Menu principal Far-Resolver ########################################
        write-host "--------------------------------"
        if (-not(test-path -path plugins)) {
            write-host "No hay carpeta de plugins"
        }
        elseif (-not($pluginsenable -eq 0)) {
            write-host "[P] Plugins Launcher" -ForegroundColor Magenta
        }
        else {
            write-host "No hay ningun plugin en la carpeta plugins"
        }
        Write-host "[1] Windows Repair" -ForegroundColor Cyan
        write-host "[2] Reparacion individual" -ForegroundColor Cyan
        write-host "[3] Aprovisionar sistema" -ForegroundColor Cyan
        write-host ""
        write-host "[A] Actualizar/Obtener" -ForegroundColor Yellow
        write-host "[N] Plugins Online" -ForegroundColor Blue
        write-host "[L] Far-Library Console" -ForegroundColor Green
        write-host ""
        write-host "[X] Exit"
        $mainmenu = read-host "Selecciona una opcion"
        switch ($mainmenu) {
            p {
                if (-not(Test-Path -path plugins)) {
                    Write-Warning "No se encuentra la carpeta de Plugins"
                    Start-Sleep -s 2
                }
                else {
                    Clear-Host
                    write-host "Far-Resolver Plugins Launcher" -ForegroundColor Magenta
                    write-host "--------------------------------"
                    $gettedGUI = Get-ChildItem plugins | Out-GridView -Title 'Plugins Launcher' -OutputMode Single
                    if ($?) {
                        if ($null -eq $gettedGUI) {
                            Write-Warning "No se ha seleccionado nada o se ha cancelado"
                            write-host ""
                            Pause
                        }
                        else {
                            & .\plugins\$gettedGUI
                            if ($?) {
                                write-host "---------------------------------------------"
                                Write-host "Plugin ejecutado correctamente" -ForegroundColor Green
                                Write-host "Ultimo plugin ejecutado: $gettedGUI"
                                write-host ""
                                pause
                            }
                            else {
                                Write-host "El Plugin ha devuelto errores en la ejecuccion"
                                write-host "Ultimo plugin ejecutado: $gettedGUI"
                                write-host ""
                                pause
                            }
                        }
                    }
                    else {
                        Write-Warning "Hay un error la obtener la lista de plugins..."
                        pause
                    }
                }
            }
    
            1 {
                Write-Warning "Esta operacion puede durar mucho tiempo"
                $continue = Read-Host "Si estas seguro de proceder, escribe [repairstart]"
                if ($continue -eq "repairstart") {
                    Clear-host
                    windowsrepair
                    exit
                }
                else {
                    Write-host "Operacion no confirmada"
                    Start-Sleep -s 4
                }
            }
    
            2 {
                Clear-Host
                individualrepair
            }
    
            a {
                $while2 = $true
                while ($while2) {
                    Clear-Host
                    write-host "Actualizador Far-Resolver" -ForegroundColor Yellow
                    write-host "Version del modulo principal: $ver"
                    write-host "Version de Far-Library $farlibraryver"
                    write-host "-------------------------------------------"
                    write-host ""
                    write-host "[1] Actualizar Far-Resolver (Modulo principal y Library)"
                    write-host "[2] Git Clone (Full Redownload Far-Resolver)"
                    write-host "[3] Instalar Winget"
                    write-host "[4] Instalar Git"
                    write-host "[5] Actualizar Far-Library"
                    write-host "[6] Actualizar ayuda de PowerShell"
                    write-host ""
                    write-host "[X] Volver a Menu Principal"
                    $option = read-host "Selecciona una opcion"
                    switch ($option) {
                        1 {
                            write-host ""
                            write-host "Actualizando Far-Resolver" -ForegroundColor Yellow
                            Invoke-WebRequest "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Resolver.ps1" -OutFile "temp.ps1"
                            if ($?) {
                                Remove-Item "Far-Resolver.ps1"
                                Rename-Item "temp.ps1" "Far-Resolver.ps1"
                                write-host "Far-Resolver actualizado" -ForegroundColor Green
                            }
                            else {
                                Write-Warning "Error al actualizar"
                            }
                            Remove-Module Far-Library
                            clear-host
                            Write-host "Actualizando Far-Library..."
                            Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "temp.psm1"
                            if ($?) {
                                Remove-Item "Far-Library.psm1"
                                Rename-Item "temp.psm1" "Far-Library.psm1"
                                Write-host "Far-Library actualizado" -ForegroundColor Green
                                Write-host "Actualizacion finalizada" -ForegroundColor Green
                                write-host "Reinicie Far-Resolver"
                                exit
                            }
                            else {
                                Write-Warning "Ha ocurrido un error al descargar Far-Library"
                                Write-host "Descarguelo manualmente"
                                write-host "https://github.com/contratop/Far-Resolver/blob/main/Far-Library.psm1"
                                pause
                            }
                            ""
                            pause
                        }
                        2 {
                            if (-not(get-command git -ErrorAction SilentlyContinue)) {
                                write-warning "No esta disponible Git, no se puede descargar la lista de plugins"
                            }
                            else {
                                write-host "Descargando repositorio..."
                                Set-Location ..
                                git clone "htts://github.com/contratop/Far-Resolver"
                                write-host "Descarga finalizada" -ForegroundColor Green
                            }
                            ""
                            pause
                        }
                        3 {
                            wingetupgrade
                        }
                        4 {
                            if (Get-Command git -ErrorAction SilentlyContinue) {
                                Write-host "Winget ya esta instalado en el equipo" -ForegroundColor Green
                            }
                            elseif (Get-Command winget -ErrorAction SilentlyContinue) {
                                write-host "Instalando Git..."
                                winget install git.git
                                if (-not($?)) {
                                    Write-Warning "Error al instalar Git"
                                }
                                else {
                                    Write-host "Instalacion de Git completada correctamente" -ForegroundColor Green
                                }
                            }
                            elseif (-not(Get-Command winget -ErrorAction SilentlyContinue)) {
                                Write-Warning "No se puede instalar Git"
                                Write-host "Winget no esta disponible"
                            }
                            else {
                                Write-Warning "Error no especificado (Desbordamiento)"
                            }
    
                            ""
                            pause
                        }
                        5 {
                            Remove-Module Far-Library
                            clear-host
                            Write-host "Actualizando Far-Library..."
                            Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "temp.psm1"
                            if ($?) {
                                Remove-Item "Far-Library.psm1"
                                Rename-Item "temp.psm1" "Far-Library.psm1"
                                Write-host "Actualizacion finalizada" -ForegroundColor Green
                                write-host "Reinicie Far-Resolver"
                                exit
                            }
                            else {
                                Write-Warning "Ha ocurrido un error al descargar Far-Library"
                                Write-host "Descarguelo manualmente"
                                write-host "https://github.com/contratop/Far-Resolver/blob/main/Far-Library.psm1"
                                pause
                            }
                        }
                        6 {
                            write-host ""
                            write-host "Actualizando ayuda de PowerShell"
                            Update-Help
                            if (-not($?)) {
                                Write-Warning "Ha ocurrido un error durante la actualizacion"
                            }
                            else {
                                write-host "Actualizacion completada" -ForegroundColor Green
                            }
                            pause
                        }
                        x {
                            $while2 = $false
                        }
                        default {
                            Write-Warning "Opcion no valida"
                            start-sleep -s 2
                        }
                    }
                }
            }

            3 {
                $whileselectos = $true
                while ($whileselectos) {
                    claer-host
                    write-host "Elige sistema operativo Target"
                    write-host "---------------------------------"
                    write-host "[1] Windows 7 o inferior"
                    write-host "[2] Windows 10 o superior"
                    write-host ""
                    write-host "[X] Volver a Menu Principal"
                    $selection = read-host "Selecciona una opcion"
                    switch ($selection) {
                        1 {
                            Clear-Host
                            <# Desplegar Cofiguracion inicial WIndows 7

1- Ofrecer activacion del sistema
2- Ofrecer desplegamiento de Office
3- Desplegar Navegador Chrome (A eleccion)
4- Desplegar 7zip (A eleccion)

#>

                            $host.UI.RawUI.WindowTitle = "Windows 7 Setup Assistant (Check Information"

                            write-host "Comprobando estado del modulo Far-Library"

                            if (Get-Module -ListAvailable -Name Far-Library) {
                                write-host "Modulo Far-Library cargado"
                            }
                            else {
                                write-host "Far-Library no esta instalado, Instalando.."
                                Write-Warning "Falta Far-Library"
                                write-host "Descargando..."
                                Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "Far-Library.psm1"
                                if (-not($?)) {
                                    write-host "Error al descargar Far-Library"
                                    Pause
                                    break
                                }
                                else {
                                    write-host "Descarga completada"
                                    write-host "Implementando..."
                                    import-module .\Far-Library.psm1
                                    if (-not($?)) {
                                        write-host "Error al implementar Far-Library"
                                        Pause
                                        break
                                    }
                                    else {
                                        write-host "Far-Library implementado correctamente" -ForegroundColor Green
                                        Pause
                                    }
                                }
                            }

                            Clear-Host
                            $host.UI.RawUI.WindowTitle = "Windows 7 Setup Assistant (Step 1/4 | System Activator)"
                            write-host "System activator"
                            write-host "------------------------"
                            write-host "[1] No activar sistema"
                            write-host "[2] Activar sistema con KMS"
                            write-host "[3] Activar sistema con WinLoader (Recomendado)"
                            $activatorsolution = Read-host "Selecciona una opcion"
                            if ($activatorsolution -eq 1) {
                                write-host "No se activara el sistema"
                            }
                            elseif ($activatorsolution -eq 2) {
                                activatekms classic
                                write-host "Funcion finalizada (activatekms classic)"
                                $null = Read-host "Presiona una tecla para continuar"
                            }
                            elseif ($activatorsolution -eq 3) {
                                activatekms oem
                                write-host "Funcion finalizada (activatekms oem)"
                                $null = Read-host "Presiona una tecla para continuar"
                            }
                            else {
                                write-host "Seleccionando opcion default [1] No activar sistema"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }

                            $host.UI.RawUI.windowTitle = "Windows 7 Setup Assistant (Step 2/4 | Office Setup)"
                            write-host "Office Setup"
                            write-host "------------------------"
                            write-host "[1] No instalar Office"
                            write-host "[2] Desplegar Office"
                            $officesolution = Read-host "Selecciona una opcion"
                            if ($officesolution -eq 1) {
                                write-host "No se desplegara Office"
                            }
                            elseif ($officesolution -eq 2) {
                                deployoffice
                                write-host "Funcion finalizada (deployoffice)"
                                $null = Read-host "Presiona una tecla para continuar"
                            }
                            else {
                                write-host "Seleccionando opcion default [1] No instalar Office"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }

                            $host.UI.RawUI.windowTitle = "Windows 7 Setup Assistant (Step 3/4 | Browser Setup)"
                            write-host "Browser Setup"
                            write-host "------------------------"
                            write-host "[1] No instalar navegador"
                            write-host "[2] Desplegar Chrome"
                            $browser = Read-host "Selecciona una opcion"
                            if ($browser -eq 1) {
                                write-host "No se desplegara navegador"
                            }
                            elseif ($browser -eq 2) {
                                # Descargar Google Chrome para WIndows 7
                                write-host "Descargando Google Chrome"
                                Invoke-WebRequest -uri "https://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile "chrome_installer.exe"
                                if (-not($?)) {
                                    Write-Warning "Error al descargar Google Chrome"
                                    write-host "Omitiendo Despliege"
                                }
                                else {
                                    write-host "Descarga completada"
                                    write-host "Desplegando Google Chrome"
                                    Start-Process -FilePath ".\chrome_installer.exe"  -Wait
                                    write-host "Despliegue completado"
                                    $null = Read-host "Presiona una tecla para continuar"
                                }
                            }
                            else {
                                write-host "Seleccionando opcion default [1] No instalar navegador"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }

                            $host.UI.RawUI.windowTitle = "Windows 7 Setup Assistant (Step 4/4 | 7zip Setup)"
                            write-host "7zip Setup"
                            write-host "------------------------"
                            write-host "[1] No instalar 7zip"
                            write-host "[2] Desplegar 7zip"
                            $sevenzip = Read-host "Selecciona una opcion"
                            if ($sevenzip -eq 1) {
                                write-host "No se desplegara 7zip"
                            }
                            elseif ($sevenzip -eq 2) {
                                # Descargar 7zip para WIndows 7
                                write-host "Descargando 7zip"
                                Invoke-WebRequest -uri "https://www.7-zip.org/a/7z1900-x64.exe" -OutFile "7z1900-x64.exe"
                                if (-not($?)) {
                                    Write-Warning "Error al descargar 7zip"
                                    write-host "Omitiendo Despliege"
                                }
                                else {
                                    write-host "Descarga completada"
                                    write-host "Desplegando 7zip"
                                    Start-Process -FilePath ".\7z1900-x64.exe"  -Wait
                                    write-host "Despliegue completado"
                                    $null = Read-host "Presiona una tecla para continuar"
                                }
                            }
                            else {
                                write-host "Seleccionando opcion default [1] No instalar 7zip"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }

                            write-host "Asistente de configuracion de Windows 7 finalizado" -ForegroundColor Green
                            $null = "Presiona cualquier tecla para salir del asistente"
                            break
                        }
                        2 {
                            # Setup Assistant for new Windows 10/11 Installations
	
                            Clear-Host
	
	
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Check information)"
	
                            write-host "Comprobando estado del modulo Far-Library"
	
                            if (Get-Module -ListAvailable -Name Far-Library) {
                                write-host "Far-Library esta instalado correctamente" -ForegroundColor Green
                            }
                            else {
                                write-host "Far-Library no esta instalado, instalando..."
                                Write-Warning "Falta Far-Library"
                                Write-host "Descargando..."
                                Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "Far-Library.psm1"
                                if (-not($?)) {
                                    Write-Warning "Error de descarga"
                                    pause
                                    break
                                }
                                else {
                                    Write-host "Descarga completada"
                                    Write-host "Implementando..."
                                    Import-Module .\Far-Library.psm1
                                    if (-not($?)) {
                                        Write-Warning "Error de implementacion"
                                        Pause
                                        break
                                    }
                                    else {
                                        Write-host "Instalacion completada" -ForegroundColor Green
                                        $null = read-host "Presiona cualquier tecla para continuar"
                                    }
                                }
                            }
	
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 0/8 | Drivers Assistant)"
                            write-host "Soluciones de drivers"
                            write-host "-----------------------------------"
                            write-host "[1] Dejar que Windows Update descargue los Drivers / Default"
                            write-host "[2] Descargar Snappy Driver en este equipo (Sin USB)"
                            write-host "[3] USB Snappy de Contratop (Conectar USB de admin ContratopDev)"
                            $DriversSolution = Read-Host "Selecciona una opcion"
                            if ($DriversSolution -eq "1") {
                                write-host "Dejando que Windows Update descargue los Drivers"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($DriversSolution -eq "2") {
                                write-host "Descargando Snappy Driver"
                                Invoke-WebRequest -uri "http://dl.drp.su/17-online/DriverPack-17-Online_from_SDI-tools.exe" -OutFile "snapdrvinst.exe"
                                if (-not($?)) {
                                    Write-Warning "Error de descarga"
                                    pause
                                    break
                                }
                                else {
                                    Write-host "Descarga completada"
                                    Write-host "Ejecutando Snappy Driver"
                                    Start-Process -FilePath "snapdrvinst.exe"
                                    $null = read-host "Cuando finalize la instalacion de Drivers. pulsa cualquier tecla para continuar"
                                }
                            }
                            elseif ($DriversSolution -eq "3") {
                                # Desarrollar esta parte en casa #########################################################################################
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] No realizar nada"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
	
                            ###### FASE 1 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 1/8 | Windows Activation)"
                            write-host "Deseas realizar una activacion de Windows?"
                            write-host "-----------------------------------"
                            write-host "[1] No / Default"
                            write-host "[2] Activacion Classic (Windows 10/11)"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "No se realizara ninguna activacion"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                write-host "Iniciando activacion de Windows"
                                activatekms classic
                                write-host "Far-Resolver ha finalizado la funcion (ActivateKMS)"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] No"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FASE 2 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 2/8 | Office)"
                            write-host "Deseas desplegar Office?"
                            write-host "-----------------------------------"
                            write-host "[1] No / Default"
                            write-host "[2] Desplegar Office"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "No se desplegara Office"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                Write-host "Iniciando despliegue de Office"
                                deployoffice
                                write-host "Far-Resolver ha finalizado la funcion (DeployOffice)"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] No"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FASE 3 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 3/8 | Winget)"
                            Write-host "Comprobando estado de Winget"
                            wingetupgrade
                            write-host "Far-Resolver ha finalizado la funcion (WingetUpgrade)"
                            $null = read-host "Presiona cualquier tecla para continuar"
	
                            ###### FASE 4 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 4/8 | Navegadores)"
                            write-host "Elige tu navegador favorito"
                            write-host "-----------------------------------"
                            write-host "[1] Microsoft Edge / Default"
                            write-host "[2] Google Chrome"
                            write-host "[3] Mozilla Firefox"
                            write-host "[4] Opera GX"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "Microsoft Edge sera tu navegador por defecto"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                write-host "Descargando Google Chrome"
                                winget install google.Chrome
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "Google Chrome ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            elseif ($selection -eq "3") {
                                write-host "Descargando Mozilla Firefox"
                                winget install Mozilla.Firefox
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "Mozilla Firefox ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            elseif ($selection -eq "4") {
                                write-host "Descargando Opera GX"
                                winget install Opera.OperaGX
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "Opera GX ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] Microsoft Edge"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FASE 5 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 5/8 | Descompresor)"
                            write-host "Elige tu descompresor favorito"
                            write-host "-----------------------------------"
                            write-host "[1] WindowsZIP / Default"
                            write-host "[2] 7-Zip"
                            write-host "[3] WinRAR"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "El descompresor por defecto de Windows sera tu descompresor por defecto"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                write-host "Descargando 7-Zip"
                                winget install 7zip.7zip
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "7-Zip ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            elseif ($selection -eq "3") {
                                write-host "Descargando WinRAR"
                                winget install WinRAR.WinRAR
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "WinRAR ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] WindowsZIP"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FASE 6 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 6/8 | IDE)"
                            write-host "Elige tu IDE favorito"
                            write-host "-----------------------------------"
                            write-host "[1] PowerShell ISE / Default"
                            write-host "[2] Visual Studio Code"
                            write-host "[3] Notepad++"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "El IDE por defecto de Windows sera tu IDE por defecto"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                write-host "Descargando Visual Studio Code"
                                winget install Microsoft.VisualStudioCode
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "Visual Studio Code ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            elseif ($selection -eq "3") {
                                write-host "Descargando Notepad++"
                                winget install "Notepad++.Notepad++"
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "Notepad++ ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] PowerShell ISE"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FASE 7 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 7/8 | Multimedia)"
                            write-host "Deseas instalar VLC?"
                            write-host "-----------------------------------"
                            write-host "[1] No (Windows Media Player) / Default"
                            write-host "[2] Si (VLC)"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "Windows Media Player sera tu reproductor multimedia por defecto"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                write-host "Descargando VLC"
                                winget install VideoLAN.VLC
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "VLC ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] No (Windows Media Player)"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FASE 8 #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (Step 8/8 | Mensajeria)"
                            write-host "Elige tu plataforma de mensajeria favorita"
                            write-host "-----------------------------------"
                            write-host "[1] Windows Default / Default"
                            write-host "[2] Telegram"
                            $selection = Read-Host "Selecciona una opcion"
                            if ($selection -eq "1") {
                                write-host "Windows Default sera tu plataforma de mensajeria por defecto"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
                            elseif ($selection -eq "2") {
                                write-host "Descargando Telegram"
                                winget install Telegram.TelegramDesktop
                                if (-not($?)) {
                                    Write-Warning Ha ocurrido un error en la Instalacion
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                                else {
                                    write-host "Telegram ha sido instalado"
                                    $null = read-host "Presiona cualquier tecla para continuar"
                                }
                            }
                            else {
                                Write-host "No se ha seleccionano una opcion valida"
                                write-host "Opcion por defecto: [1] Windows Default"
                                $null = read-host "Presiona cualquier tecla para continuar"
                            }
	
                            ###### FIN #################################################
                            Clear-Host
                            $host.UI.RawUI.windowTitle = "Setup Assistant (FINALIZADO)"
                            write-host "El asistente de configuracion ha finalizado" -ForegroundColor Green
                            $null = read-host "Presiona cualquier tecla para continuar"
                            Clear-Host
                            $whileselectos = $false
	
                        }

                        x {
                            write-host "Volviendo al menu principal"
                            $whileselectos = $false
                        }
                        default {
                            Write-Warning "Opcion no valida"
                            start-sleep -s 2
                        }
                    }
                }
            }
    
    
            n {
                Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/contratop/Far-Resolver/main/onlineplugins.ps1" | Invoke-Expression
                if (-not($?)) {
                    Write-Warning "Error de ejecucion"
                }
                pause
            }
    
            l {
                Clear-Host
                FarLibraryVersion
                if (-not($?)) {
                    Write-Warning "Error de ejecucion"
                }
                write-host "Comandos disponibles en Far-Library"
                write-host "-----------------------------------"
                Get-Command -Module Far-Library
                write-host ""
                read-host "Presione cualquier tecla para salir a consola"
                exit
    
    
    
            }
    
            x {
                write-host "Far-resolver finalizado por el usuario (opcion X)" -ForegroundColor Yellow
                exit
            }
    
            default {
                Write-Warning "Opcion no reconocida"
                Start-Sleep -s 2
            }
        }
    
    
    
    }
    
}
finally {
    Write-host "Far-Resolver finalizado" -ForegroundColor Green
    $null = Read-Host "Presione cualquier tecla para salir"
    exit
}