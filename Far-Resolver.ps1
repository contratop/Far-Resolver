#Far Resolver 1.0
# Header  ##########################
Clear-Host
$ver = "0.1"
$Host.UI.RawUI.WindowTitle = "Far Resolver Ver. $ver"


# Parse Check #######################
$OSVersion = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
$architectureproc = (Get-WmiObject -Class Win32_ComputerSystem).SystemType
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
if(-not($OSVersion -match "Windows")){ # Check OS
    Write-host "Sistema Operativo $OSVersion"
    Write-Warning "No se detecta O.S Windows"
    $errorcounter =+ 1
}
else{
    Write-host "Sistema Operativo $OSVersion"
    Write-host "O.S OK" -ForegroundColor Green
}
""
if(-not($architectureproc -match "64")){ # Check Bits
    Write-host "Arquitectura CPU: $architectureproc"
    Write-Warning "64 Bits CPU Not detected"
    $errorcounter =+ 1
}
else{
    Write-host "Arquitectuta CPU: $architectureproc"
    Write-host "64 Bits OK" -ForegroundColor Green
}
""



# Directory Parse ################################
if(-not(test-path -path plugins)){ # Check Plugins Dir
    Write-Warning "Plugins Folder not found"
    $errorcounter =+ 1
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
    $errorcounter =+ 1
}
else{
    Write-host "Git OK" -ForegroundColor Green
}
""
if(-not(Get-Command winget)){
    Write-Warning "Winget not detected"
    $errorcounter = +1
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
            $gettedGUI = Get-ChildItem plugins | Out-GridView -Title 'Selecciona un script' -OutputMode Single
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
                        Write-host "Scipt ejecutado correctamente" -ForegroundColor Green
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
            write-host "Winget Installer Work in progress"
            Start-Sleep -s 2
        }

        a{
            $while2 = $true
            while($while2){
                Clear-Host
                write-host "Actualizador Far-Resolver" -ForegroundColor Yellow
                write-host "Version del modulo principal: $ver"
                write-host "-------------------------------------------"
                write-host ""
                write-host "[1] Actualizar Far-Resolver Modulo Inicial"
                write-host "[2] Actualizar / Descargar lista de plugins"
                write-host "[3] Instalar Winget"
                write-host "[4] Instalar Git"
                write-host ""
                write-host "[X] Volver a Menu Principal"
                $option = read-host "Selecciona una opcion"
                switch($option){
                    1{
                        write-host ""
                        write-host "Actualizando Far-Resolver" -ForegroundColor Yellow
                        
                    }
                    2{

                    }
                    3{

                    }
                    4{

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