# Far-Resolver
Herramienta multiproposito para Windows

## Herramientas rapidas de Powershell
Permite realizar multiples acciones en el sistema de manera interactiva

## Descarga
Antes de descargar y/o ejecutar:

***Ejecutar como administrador***
````
Set-ExecutionPolicy Unrestricted
````
**Opcional:** *Puedes establecer luego ``` Set-ExecutionPolicy Restricted``` para volver a bloquear la ejecuccion de script*

### Descargar y ejecutar

````
Invoke-WebRequest -uri "https://github.com/contratop/Far-Resolver/raw/main/Far-Resolver.ps1" -OutFile "Far-Resolver.ps1" ;; ./Far-Resolver.ps1
````

### Ejecutar Online
````
Invoke-WebRequest -UseBasicParsing "https://github.com/contratop/Far-Resolver/raw/main/Far-Resolver.ps1" | Invoke-Expression
````