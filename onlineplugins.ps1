clear-host
$onlinepluginver = "0.3"


## Plugins database ##

# Plugin 1 (WinUtils)
$pluginname1 = "WinUtils"
$pluginsauthor1 = "@christitustech"
$pluginsurlraw1 = "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/winutil.ps1" 

# Plugin 2 (Defendermanipulator)
$pluginname2 = "Defender Manipulator"
$pluginsauthor2 = "@ContratopDev"
$pluginsurlraw2 = "https://github.com/contratop/Far-Resolver/raw/main/plugins/DefenderManipulator.ps1"

# Plugin 3 (Admin Downgrader)
$pluginname3 = "Admin Downgrader"
$pluginsauthor3 = "@ContratopDev"
$pluginsurlraw3 = "https://github.com/contratop/Far-Resolver/raw/main/plugins/AdminDowngrader.ps1" # PENDING SETTING

# Plugin 4 (Power Downloader)
$pluginname4 = "Power Downloader"
$pluginsauthor4 = "@ContratopDev"
$pluginsurlraw4 = "https://github.com/contratop/PowerDownloader" # PENDING SETTING



function executemode {

    $whileonline2 = $true
    while ($whileonline2) {
        clear-host
        write-host "Online Plugin Version: $onlinepluginver"
        write-host "Modo Online" -ForegroundColor Cyan
        write-host "Mostrando plugins online"
    
        write-host " " # MENU DE PLUGINS ONLINE ########################################
    
        write-host "[1] - $pluginname1 ($pluginsauthor1)" 
        write-host "[2] - $pluginname2 ($pluginsauthor2)"
        write-host "[3] - $pluginname3 ($pluginsauthor3)"
        write-host ""
        write-host "[M] - Manual execution"
        if (test-path -path "plugins") {
            write-host "[D] - Download Mode" -ForegroundColor Blue
        }
        else {
            write-host "[D] - Download Mode (Create plugin directory)" -ForegroundColor Blue
        }
        write-host "[x] - Salir" -ForegroundColor Yellow
    
        $getplugins = read-host "Escribe el numero del plugin que quieres instalar"
    
        if ($getplugins -eq "1") {
            Invoke-WebRequest -UseBasicParsing "$pluginsurlraw1" | Invoke-Expression
            if ($?) {
                write-host "Plugin executado correctamente"
            }
            else {
                write-host "Error en la ejecucion del plugin"
            }
            write-host ""
            exit
        }
        elseif ($getplugins -eq "2") {
            Invoke-WebRequest -UseBasicParsing "$pluginsurlraw2" | Invoke-Expression
            if ($?) {
                write-host "Plugin executado correctamente"
            }
            else {
                write-host "Error en la ejecucion del plugin"
            }
            write-host ""
            exit
        }

        elseif ($getplugins -eq "3") {
            Invoke-WebRequest -UseBasicParsing "$pluginsurlraw3" | Invoke-Expression
            if ($?) {
                write-host "Plugin executado correctamente"
            }
            else {
                write-host "Error en la ejecucion del plugin"
            }
            write-host ""
            exit
        }

        elseif ($getplugins -eq "M") {
            $manual = read-host "Escribe la URL del plugin que quieres ejecutar"
            if (($manual -match "http") -and ($manual -match ".ps1")) {
                Invoke-WebRequest -UseBasicParsing $manual | Invoke-Expression
                if (-not($?)) {
                    Write-Warning "Codigo de salida con errores"
                }
                else {
                    write-host "Plugin ejecutado correctamente" -ForegroundColor Green
                }
                pause
            }
            else {
                Write-Warning "URL invalida"
                Start-Sleep -s 2
            }
        }
    
        elseif ($getplugins -eq "d") {
            if (-not(test-path -path plugins)) {
                write-host "Carpeta plugins no detectada. creando..."
                mkdir plugins
                write-host "Carpeta plugins creada" -ForegroundColor Green
                Start-Sleep -s 1
            }
            downloadmode
            $whileonline2 = $false
        }
    
        elseif ($getplugins -eq "x") {
            write-host "Saliendo..."
            write-host ""
            $whileonline2 = $false
        }
        else {
            write-warning "Plugin no encontrado"
            write-host ""
            start-sleep -s 2
        }
    }
}


function downloadmode {
    $whileonline2 = $true
    while ($whileonline2) {
        clear-host
        write-host "Online Plugin Version: $onlinepluginver"
        write-host "Modo Descarga" -ForegroundColor Cyan
        write-host "Mostrando plugins para descargar"
        
        write-host "" # MENU MODO DESCARGA ##############################

        write-host "[1] - $pluginname1 ($pluginsauthor1)"
        write-host "[2] - $pluginname2 ($pluginsauthor2)"
        write-host ""
        write-host "[M] - Manual Download"
        write-host "[E] - Execute Mode" -ForegroundColor Blue
        write-host "[x] - Salir" -ForegroundColor Yellow

        $getplugins = read-host "Escribe el numero del plugin que quieres descargar"

        if ($getplugins -eq "1") {
            Invoke-WebRequest -uri "$pluginsurlraw1" -OutFile "plugins\winutil.ps1"
            if ($?) {
                write-host "Plugin descargado correctamente" -ForegroundColor Green
            }
            else {
                write-host "Error en la descarga del plugin"
            }
            write-host ""
        }
        elseif ($getplugins -eq "2") {
            Invoke-WebRequest -uri "$pluginsurlraw2" -OutFile "plugins\DefenderManipulator.ps1"
            if ($?) {
                write-host "Plugin descargado correctamente" -ForegroundColor Green
            }
            else {
                write-host "Error en la descarga del plugin"
            }
            write-host ""
        }

        elseif($getplugins -eq "3"){
            Invoke-WebRequest -uri "$pluginsurlraw3" -OutFile "plugins\AdminDowngrader.ps1"
            if ($?) {
                write-host "Plugin descargado correctamente" -ForegroundColor Green
            }
            else {
                write-host "Error en la descarga del plugin"
            }
            write-host ""
        }


        elseif ($getplugins -eq "M") {
            $manual = read-host "Escribe la URL del plugin que quieres descargar"
            if (($manual -match "http") -and ($manual -match ".ps1")) {
                $manualname = read-host "Escribe el nombre del plugin"
                Invoke-WebRequest -uri $manual -OutFile "plugins\$manualname.ps1"
                if (-not($?)) {
                    Write-Warning "Error en la descarga del plugin"
                }
                else {
                    write-host "Plugin descargado correctamente" -ForegroundColor Green
                }
                pause
            }
            else {
                Write-Warning "URL invalida"
                Start-Sleep -s 2
            }
        }

        elseif ($getplugins -eq "e") {
            executemode
            $whileonline2 = $false
        }

        elseif ($getplugins -eq "x") {
            write-host "Saliendo..."
            write-host ""
            $whileonline2 = $false
        }
        else {
            write-warning "Plugin no encontrado"
            write-host ""
            start-sleep -s 2
        }
    }
}






executemode
