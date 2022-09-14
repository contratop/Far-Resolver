
$onlinepluginver = "0.1"
write-host "Online Plugin Version: $onlinepluginver"
write-host "Mostrando plugins online"

write-host " "

write-host "[1] - winutils (@christitustech)"

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