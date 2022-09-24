clear-host
$onlinepluginver = "0.2.2"

function executemode{

    $whileonline2 = $true
    while($whileonline2){
    clear-host
    write-host "Online Plugin Version: $onlinepluginver"
    write-host "Modo Online" -ForegroundColor Cyan
    write-host "Mostrando plugins online"
    
    write-host " " # MENU DE PLUGINS ONLINE ########################################
    
    write-host "[1] - winutils (@christitustech)"
    write-host "[2] - Defender Manipulator (@ContratopDev)"
    write-host ""
    write-host "[M] - Manual execution"
    if(test-path -path "plugins"){
        write-host "[D] - Download Mode" -ForegroundColor Blue
    }
    else{
        write-host "[D] - Download Mode (Create plugin directory)" -ForegroundColor Blue
    }
    write-host "[x] - Salir" -ForegroundColor Yellow
    
    $getplugins = read-host "Escribe el numero del plugin que quieres instalar"
    
    if ($getplugins -eq "1") {
        Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/winutil.ps1" | Invoke-Expression
        if($?) {
            write-host "Plugin executado correctamente"
        } else {
            write-host "Error en la ejecucion del plugin"
        }
        write-host ""
        exit
    }
    elseif($getplugins -eq "2"){
        Invoke-WebRequest -UseBasicParsing "https://github.com/contratop/Far-Resolver/raw/main/plugins/DefenderManipulator.ps1" | Invoke-Expression
        if($?) {
            write-host "Plugin executado correctamente"
        } else {
            write-host "Error en la ejecucion del plugin"
        }
        write-host ""
        exit
    }

    elseif($getplugins -eq "M"){
        $manual = read-host "Escribe la URL del plugin que quieres ejecutar"
        if(($manual -match "http")-and($manual -match ".ps1")){
            Invoke-WebRequest -UseBasicParsing $manual | Invoke-Expression
            if(-not($?)){
                Write-Warning "Codigo de salida con errores"
            }
            else{
                write-host "Plugin ejecutado correctamente" -ForegroundColor Green
            }
            pause
        }
        else{
            Write-Warning "URL invalida"
            Start-Sleep -s 2
        }
    }
    
    elseif($getplugins -eq "d"){
        if(-not(test-path -path plugins)){
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
    else{
        write-warning "Plugin no encontrado"
        write-host ""
        start-sleep -s 2
    }
    }
}


function downloadmode{
    $whileonline2 = $true
    while($whileonline2){
        clear-host
        write-host "Online Plugin Version: $onlinepluginver"
        write-host "Modo Descarga" -ForegroundColor Cyan
        write-host "Mostrando plugins para descargar"
        
        write-host "" # MENU MODO DESCARGA ##############################

        write-host "[1] - winutils (@christitustech)"
        write-host "[2] - Defender Manipulator (@ContratopDev)"
        write-host ""
        write-host "[M] - Manual Download"
        write-host "[E] - Execute Mode" -ForegroundColor Blue
        write-host "[x] - Salir" -ForegroundColor Yellow

        $getplugins = read-host "Escribe el numero del plugin que quieres descargar"

        if ($getplugins -eq "1") {
            Invoke-WebRequest -uri "https://raw.githubusercontent.com/ChrisTitusTech/winutil/main/winutil.ps1" -OutFile "plugins\winutil.ps1"
            if($?) {
                write-host "Plugin descargado correctamente" -ForegroundColor Green
            } else {
                write-host "Error en la descarga del plugin"
            }
            write-host ""
        }
        elseif($getplugins -eq "2"){
            Invoke-WebRequest -uri "https://github.com/contratop/Far-Resolver/raw/main/plugins/DefenderManipulator.ps1" -OutFile "plugins\DefenderManipulator.ps1"
            if($?) {
                write-host "Plugin descargado correctamente" -ForegroundColor Green
            } else {
                write-host "Error en la descarga del plugin"
            }
            write-host ""
        }

        elseif($getplugins -eq "M"){
            $manual = read-host "Escribe la URL del plugin que quieres descargar"
            if(($manual -match "http")-and($manual -match ".ps1")){
                $manualname = read-host "Escribe el nombre del plugin"
                Invoke-WebRequest -uri $manual -OutFile "plugins\$manualname.ps1"
                if(-not($?)){
                    Write-Warning "Error en la descarga del plugin"
                }
                else{
                    write-host "Plugin descargado correctamente" -ForegroundColor Green
                }
                pause
            }
            else{
                Write-Warning "URL invalida"
                Start-Sleep -s 2
            }
        }

        elseif($getplugins -eq "e"){
            executemode
            $whileonline2 = $false
        }

        elseif ($getplugins -eq "x") {
            write-host "Saliendo..."
            write-host ""
            $whileonline2 = $false
        }
        else{
            write-warning "Plugin no encontrado"
            write-host ""
            start-sleep -s 2
        }
    }
}






executemode
