#Far Resolver 1.0
# Header  ##########################
Remove-Module Far-Library
Clear-Host
$ver = "0.2.1.3"
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
if(-not(test-path -path "Far-Library.psm1")){
    Write-Warning "Falta Far-Library"
    Write-host "Descargando..."
    Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "Far-Library.psm1"
    if($?){
        Import-Module .\Far-Library.psm1
    }
    else{
        Write-Warning "Ha ocurrido un error al descargar Far-Library"
        Write-host "Descarguelo manualmente"
        write-host "https://github.com/contratop/Far-Resolver/blob/main/Far-Library.psm1"
        exit
    }
}
else{
    Import-Module .\Far-Library.psm1
    if(-not($?)){
        Write-Warning "El modulo Far-Library no ha cargado"
        $errorcounter = $errorcounter + 1
    }
}



if(-not($OSVersion -match "Windows")){ # Check OS
    Write-host "Sistema Operativo $OSVersion"
    Write-Warning "No se detecta O.S Windows"
    $errorcounter = $errorcounter + 1
}
else{
    Write-host "Sistema Operativo $OSVersion"
    Write-host "O.S OK" -ForegroundColor Green
}
""
if(-not($architectureproc -match "64")){ # Check Bits
    Write-host "Arquitectura CPU: $architectureproc"
    Write-Warning "64 Bits CPU Not detected"
    $errorcounter = $errorcounter + 1
}
else{
    Write-host "Arquitectuta CPU: $architectureproc"
    Write-host "64 Bits OK" -ForegroundColor Green
}
""



# Directory Parse ################################
if(-not(test-path -path plugins)){ # Check Plugins Dir
    Write-Warning "Plugins Folder not found"
    $errorcounter = $errorcounter + 1
}
else{
    $countps1 = Get-ChildItem plugins\*.ps1 -Recurse -File | Measure-Object | Select-Object Count
    write-host "Plugins: " $countps1.count
    Write-Host "Plugins OK" -ForegroundColor Green
}
""




# Command Parse #####################################
if(-not(Get-Command git -ErrorAction SilentlyContinue)){
    Write-Warning "Git not installed"
    $errorcounter = $errorcounter + 1
}
else{
    Write-host "Git OK" -ForegroundColor Green
}
""
if(-not(Get-Command winget -ErrorAction SilentlyContinue)){
    Write-Warning "Winget not detected"
    $errorcounter = $errorcounter + 1
}
else{
    write-host "Winget OK" -ForegroundColor Green
}
""
write-host "Powershell Version: " (($PSVersionTable).PSVersion)



# Stop si detecta porlomenos 1 error, para depurar errores
Write-host ""
if(-not($errorcounter -eq 0)){
    Write-Warning "Errores detectados: $errorcounter"
    Write-Warning "Hay errores de integridad, funcionalidad limitada"
    write-host ""
    $continue = read-host "Proceder de todos modos? NO RECOMENDABLE [continue]"
    if(-not($continue -eq "continue")){
        Write-Warning "Ejecuccion cancelada"
        exit
    }
}
else{
    pause
}












# MENU PRINCIPAL #####################################

$while1 = $true
while($while1){
    clear-host
    Write-host "Far-Resolver Console Version $ver"
    if(-not(Get-Module Far-Library)){Write-Warning "Modulo Far-Library no cargado"}
    else{FarLibraryVersion}
    if(-not($errorcounter -eq 0)){Write-Warning "Ejecutandose con errores de integridad"}
    if($gettedGUI){Write-host "Ultimo plugin ejecutado: $gettedGUI"}
    write-host ""
    if($countps1.count -eq 0){
        Write-Warning "No hay plugins disponibles"
        $pluginsenable = 0
    }
    else{
        write-host "Plugins PS1:" $countps1.count "plugins detectados" -ForegroundColor Magenta
    }
    write-host ""
    Write-host "Far-Resolver Main Menu"
    write-host "--------------------------------"
    if(-not($pluginsenable -eq 0)){
        write-host "[P] Plugins Launcher" -ForegroundColor Magenta
    }
    Write-host "[1] Windows Repair" -ForegroundColor Cyan
    write-host ""
    write-host "[A] Actualizar/Obtener" -ForegroundColor Yellow
    write-host ""
    write-host "[X] Exit"
    $mainmenu = read-host "Selecciona una opcion"
    switch($mainmenu){
        p{
            Clear-Host
            write-host "Far-Resolver Plugins Launcher" -ForegroundColor Magenta
            write-host "--------------------------------"
            $gettedGUI = Get-ChildItem plugins | Out-GridView -Title 'Plugins Launcher' -OutputMode Single
            if($?){
                if($null -eq $gettedGUI){
                    Write-Warning "No se ha seleccionado nada o se ha cancelado"
                    write-host ""
                    Pause
                }
                else{
                    & .\plugins\$gettedGUI
                    if($?){
                        write-host "---------------------------------------------"
                        Write-host "Plugin ejecutado correctamente" -ForegroundColor Green
                        Write-host "Ultimo plugin ejecutado: $gettedGUI"
                        write-host ""
                        pause
                    }
                    else{
                        Write-host "El Plugin ha devuelto errores en la ejecuccion"
                        write-host "Ultimo plugin ejecutado: $gettedGUI"
                        write-host ""
                        pause
                    }
                }
            }
            else{
                Write-Warning "Hay un error la obtener la lista de plugins..."
                pause
            }
        }

        1{
            Write-Warning "Esta operacion puede durar mucho tiempo"
            $continue = Read-Host "Si estas seguro de proceder, escribe [repairstart]"
            if($continue -eq "repairstart"){
                Clear-host
                windowsrepair
                exit
            }
            else{
                Write-host "Operacion no confirmada"
                Start-Sleep -s 4
            }
        }

        a{
            $while2 = $true
            while($while2){
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
                write-host ""
                write-host "[X] Volver a Menu Principal"
                $option = read-host "Selecciona una opcion"
                switch($option){
                    1{
                        write-host ""
                        write-host "Actualizando Far-Resolver" -ForegroundColor Yellow
                        Invoke-WebRequest "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Resolver.ps1" -OutFile "temp.ps1"
                        if($?){
                            Remove-Item "Far-Resolver.ps1"
                            Rename-Item "temp.ps1" "Far-Resolver.ps1"
                            write-host "Far-Resolver actualizado" -ForegroundColor Green
                        }
                        else{
                            Write-Warning "Error al actualizar"
                        }
                        Remove-Module Far-Library
                        clear-host
                        Write-host "Actualizando Far-Library..."
                        Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "temp.psm1"
                        if($?){
                            Remove-Item "Far-Library.psm1"
                            Rename-Item "temp.psm1" "Far-Library.psm1"
                            Write-host "Far-Library actualizado" -ForegroundColor Green
                            Write-host "Actualizacion finalizada" -ForegroundColor Green
                            write-host "Reinicie Far-Resolver"
                            exit
                        }
                        else{
                            Write-Warning "Ha ocurrido un error al descargar Far-Library"
                            Write-host "Descarguelo manualmente"
                            write-host "https://github.com/contratop/Far-Resolver/blob/main/Far-Library.psm1"
                            pause
                        }
                        ""
                        pause
                    }
                    2{
                        if(-not(get-command git -ErrorAction SilentlyContinue)){
                            write-warning "No esta disponible Git, no se puede descargar la lista de plugins"
                        }
                        else{
                            write-host "Descargando repositorio..."
                            Set-Location ..
                            git clone "htts://github.com/contratop/Far-Resolver"
                            write-host "Descarga finalizada" -ForegroundColor Green
                        }
                        ""
                        pause
                    }
                    3{
                        wingetupgrade
                    }
                    4{
                        if(Get-Command git -ErrorAction SilentlyContinue){
                            Write-host "Winget ya esta instalado en el equipo" -ForegroundColor Green
                        }
                        elseif(Get-Command winget -ErrorAction SilentlyContinue){
                            write-host "Instalando Git..."
                            winget install git.git
                            if(-not($?)){
                                Write-Warning "Error al instalar Git"
                            }
                            else{
                                Write-host "Instalacion de Git completada correctamente" -ForegroundColor Green
                            }
                        }
                        elseif(-not(Get-Command winget -ErrorAction SilentlyContinue)){
                            Write-Warning "No se puede instalar Git"
                            Write-host "Winget no esta disponible"
                        }
                        else{
                            Write-Warning "Error no especificado (Desbordamiento)"
                        }

                        ""
                        pause
                    }
                    5{
                        Remove-Module Far-Library
                        clear-host
                        Write-host "Actualizando Far-Library..."
                        Invoke-WebRequest -uri "https://raw.githubusercontent.com/contratop/Far-Resolver/main/Far-Library.psm1" -OutFile "temp.psm1"
                        if($?){
                            Remove-Item "Far-Library.psm1"
                            Rename-Item "temp.psm1" "Far-Library.psm1"
                            Write-host "Actualizacion finalizada" -ForegroundColor Green
                            write-host "Reinicie Far-Resolver"
                            exit
                        }
                        else{
                            Write-Warning "Ha ocurrido un error al descargar Far-Library"
                            Write-host "Descarguelo manualmente"
                            write-host "https://github.com/contratop/Far-Resolver/blob/main/Far-Library.psm1"
                            pause
                        }
                    }
                    x{
                        $while2 = $false
                    }
                    default{
                        Write-Warning "Opcion no valida"
                        start-sleep -s 2
                    }
                }
            }
        }




        x{
            write-host "Far-resolver finalizado por el usuario (opcion X)" -ForegroundColor Yellow
            exit
        }

        default{
            Write-Warning "Opcion no reconocida"
            Start-Sleep -s 2
        }
    }



}