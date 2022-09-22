clear-host
$onlinepluginver = "0.2.2"

function executemode{

    $whileonline2 = $true
    while($whileonline2){
    clear-host
    write-host "Online Plugin Version: $onlinepluginver"
    write-host "Modo Online" -ForegroundColor Cyan
    write-host "Mostrando plugins online"
    
    write-host " "
    
    write-host "[1] - winutils (@christitustech)"
    write-host ""
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
        
        write-host ""

        write-host "[1] - winutils (@christitustech)"
        write-host ""
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
