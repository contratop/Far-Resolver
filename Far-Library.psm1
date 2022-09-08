Write-host "Far-Library cargado correctamente" -ForegroundColor Green
$farlibraryver = "0.1"










function FarLibraryVersion{
    Write-host "Far-Library Version $farlibraryver" -ForegroundColor Green
}





function wingetupgrade{
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