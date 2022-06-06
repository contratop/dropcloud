#Autoadmin Init
clear-host
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

if (Test-Path -Path "F:\FAR-Resolver.ps1"){
    Set-Location F:\
}
elseif (Test-Path -Path "E:\FAR-Resolver.ps1"){
    Set-Location E:\
}
elseif (Test-Path -Path "D:\FAR-Resolver.ps1"){
    Set-LocalGroup D:\
}
else{
    write-warning "No se detecta la ruta de ejecuccion de FAR-Resolver automaticamente"
    newlocation
}


    function newlocation {
        Get-PSDrive
        $newpath = read-host "Escribe la letra de unidad de ejecuccion: "
        Set-Location ${newpath}:\
        if ($?){
            clear-host
        }
        else{
            clear-host
            write-warning "$newpath no existe o no esta montado"
            Write-Host ""
            start-sleep -Seconds 3
            promptuserinit
        }
    }




#AutoAdmin End
Clear-Host
$host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev"


function execmode {
    write-host "Ubicacion de ejecuccion: $pwd"
    if (Test-Path .\FAR-Resolver.ps1){
        write-host "Ubicacion valida" -ForegroundColor Green
    }
    else{
        Write-Warning "Ubicacion Invalida seleccionada"
    }
    write-host ""
    $title    = 'FAR-Resolver'
    $question = 'Seleccionar modo de ejecuccion'
    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Asistido'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Manual'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Diagnostico'))
    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        Clear-Host
    } elseif ($decision -eq 1) {
        Write-Warning "Modo manual (Avanzado) seleccionado"
        Start-Sleep -Seconds 5
        noassistadvanced
    }
    elseif ($decision -eq 2){
        dxdiagcheck
        clear-host
        execmode
    }    
    else {
        write-warning "Opcion introducida no valida"
        Start-Sleep 2
        execmode
    }
}

    function startguimode {
        Add-Type -AssemblyName PresentationFramework
        if ($?){
        }
        else {
            Write-Warning "Ha ocurrido un error al ejecutar el modo GUI, Continuando en modo SOLO CLI"
        }
    }

    #Sistema de decisiones avanzada INIT///
    function noassistadvanced {
        if (Test-Path .\FAR-Resolver.ps1){

        }
        else{
            Write-Warning "Ubicacion Invalida seleccionada"
        }
        $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (MODO MANUAL)"
        clear-host
        write-host "FAR-Resolver Manual Mode"
        write-host ""
        Write-Host "1- Winget Check" #Implementado
        Write-Host "2- Check Defender" #Implementado
        Write-Host "3- Test command Exist" #Implementado
        Write-Host "4- Update Defender" #Implementado
        Write-Host "5- Defender QuickScan" #Implementado
        Write-Host "6- System Health Restore" #Implementado
        write-Host "7- Escaner de eficiencia energetica" #Implementado
        write-Host "8- Escaner basico de Malware" #Implementado
        Write-Host "9- Check de firma de controladores validos" #Implementado
        Write-Host "---"
        if (Test-Path FAR-Resolver.ps1){
                    Write-Host "m- Menu de Aplicaciones"
        }
        else{
            Write-Host "m- Menu de Aplicaciones (Ubicacion Invalida)" -ForegroundColor Yellow
            write-host "xx- Seleccionar otra ubicacion" -ForegroundColor Cyan
        }




        #////METER MENU POR SEPARADO DE FUNCIONES EXTRAS
        #FUNCION WIFIDUMP (Clear fuera de funcion)
        
        $menusel = Read-Host -Prompt "Numero: "
        if ($menusel -eq 1) {
            write-host "Ejecutando funcion aislada (wingetguidecheck)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [wingetguidecheckinit]"
            wingetguidecheckinit
            write-host "la funcion wingetguidecheck ha finalizado"
            pause
            noassistadvanced
        }
        elseif ($menusel -eq 2) {
            write-Host "Ejecutando funcion aislada (checkdefender)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [checkdefender]"
            checkdefender
            write-host "la funcion checkdefender ha finalizado"
            pause
            noassistadvanced
        }
        elseif ($menusel -eq 3) {
            write-Host ""
            $cmdname = Read-Host -Prompt "Escriba el comando a testear"
            write-Host "Ejecutando funcion aislada (test-commandexists)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [test-commandexists]"
            Test-CommandExists $cmdname
            noassistadvanced
        }
        elseif ($menusel -eq 4) {
            Write-Host "Ejecutando funcion aislada (updatedefender)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [updatedefender]"
            updatedefender
            write-host "la funcion updatedefender ha finalizado"
            pause
            noassistadvanced
        }    
        elseif ($menusel -eq 5) {
            Write-Host "Ejecutando funcion aislada (scandefender)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [scandefender]"
            scandefender
            write-host "la funcion scandefender ha finalizado"
            pause
            noassistadvanced
        }
        elseif ($menusel -eq 6) {
            Write-Host "Ejecutando funcion aislada (systemhealthrestore1)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [systemhealthrestore1]"
            systemhealthrestore1
            shrphase1
            write-host "la funcion systemhealthrestore ha finalizado"
            pause
            noassistadvanced
        }
        elseif ($menusel -eq 7){
            write-host "Ejecutando funcion aislada (dumpenergydata)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [dumpenergydata]"
            dumpenergydata
            Write-Host "la funcion dumpenergydata ha finalizado"
            pause
            noassistadvanced
        }
        elseif($menusel -eq 8){
            write-Host "Ejecutand funcion aislada (checkmrt)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [checkmrt]"
            checkmrt
            Write-Host "la funcion checkmrt ha finalizado"
            pause
            noassistadvanced
        }
        elseif($menusel -eq 9){
            write-host "Ejecutando funcion aislada (sigverifcheck)"
            $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Funcion aislada) [sigverifcheck]"
            sigverifcheck
            Write-Host "la funcion sigverifcheck ha finalizado correctamente"
            pause
            noassistadvanced
        }
        elseif($menusel -eq "m"){
            clear-host
            menuapps
            noassistadvanced
        }
        elseif($menusel -eq "xx"){
            clear-host
            newlocation
            noassistadvanced
        }
        else{
            write-host "Opcion no valida"
            start-sleep -Seconds 2
            clear-host
            noassistadvanced
        }
        
    
    }
    

    #Sistema de decisiones avanzadas END///
    function menuapps {
        clear-host
        if (Test-Path .\FAR-Resolver.ps1){

        }
        else{
            Write-Warning "Ubicacion Invalida seleccionada (LAS APPS NO VAN A FUNCIONAR)"
        }
        $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Menu de apps)"
        if(-not(Test-Path .\FAR-Resolver.ps1)){
            write-host "xx- Seleccionar otra ubicacion" -ForegroundColor Cyan
            write-host "---"
        }
        Write-Host "1- FastWinget Utility" #Programa funcionando correctamente
        write-Host "2- Unlocker Utility" #Programa funcionando correctamente
        Write-Host "3- WifiDump Utility" 
        if (Test-Path .\WifiDump_ProfileDump.dat){
            Write-Host "ww- Hay 1 volcado disponible (WifiDump_ProfileDump.dat)" -foregroundcolor Green
        }
        Write-Host "4- GUIFormat FAT32 Utility"
        # //////////////// METER PATATATUBE ////////////////
        write-host "---"
        write-host "x- Volver a Menu Manual"
        write-host "d- Abrir diagnostico del sistema"
        write-host "v- Volcar informacion del sistema"
        if (Test-Path .\Sysdump.dat){
            write-host "vv- Hay 1 volcado disponible (Sysdump.dat)" -ForegroundColor Green
        }

        
        $menuappsel = read-host "Selecciona una opcion: "


        if ($menuappsel -eq 1){
            clear-host
            fastwinget
        }
        elseif ($menuappsel -eq 2){
            iobitunlocker
        }
        elseif ($menuappsel -eq 3){
            clear-host
            wifidump
        }
        elseif ($menuappsel -eq 4){
            guiformatter
        }


        elseif ($menuappsel -eq "x"){
            write-host "Volviendo a Modo Manual"
            noassistadvanced
        }
        elseif ($menuappsel -eq "d"){
            dxdiagcheck
            clear-host
            menuapps
        }
        elseif ($menuappsel -eq "v"){
            write-host ""
            dumpsysdata
            write-host ""
            menuapps

        }
        elseif ($menuappsel -eq "vv"){
            if (Test-Path Sysdump.dat){
                Get-ChildItem Sysdump.dat
                $title    = 'Volcado de datos del sistema (Sysdump.dat)'
                $question = 'Operacion a realizar'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Abrir (notepad.exe)'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Borrar'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Back'))

        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                if ($decision -eq 0){
                    notepad Sysdump.dat
                    clear-host
                    menuapps
                }
                elseif ($decision -eq 1){
                    write-warning "Solicitud de borrado de datos (Sysdump.dat)"
                    $passdelete = read-host "Escribe DELETE para confirmar borrado: "
                    if($passdelete -eq "DELETE"){
                    clear-host
                    Write-Warning "Eliminando Sysdump.dat"
                    Remove-Item Sysdump.dat
                    if ($?){
                        write-host "Sysdump.dat eliminado" -foregroundcolor Green
                        Start-Sleep -Seconds 2
                        menuapps
                    }
                    else{
                        Write-Warning "Error al eliminar Sysdump.dat"
                        write-host "Eliminelo manualmente" -foregroundcolor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 5
                        menuapps
                    }
                }
            }
            else{
                Write-Host "No es una opcion valida"
                pause
                menuapps
            }

        }

      else {
            Write-Host "No es una opcion valida"
            pause
            menuapps
        }
        break
    }
        elseif ($menuappsel -eq "ww"){
            if (Test-Path WifiDump_ProfileDump.dat){
                Get-ChildItem WifiDump_ProfileDump.dat
                $title    = 'Volcado de datos del sistema (WifiDump_ProfileDump.dat)'
                $question = 'Operacion a realizar'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Abrir (notepad.exe)'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Borrar'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Back'))

        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                if ($decision -eq 0){
                    notepad WifiDump_ProfileDump.dat
                    clear-host
                    menuapps
                }
                elseif ($decision -eq 1){
                    write-warning "Solicitud de borrado de datos (WifiDump_ProfileDump.dat)"
                    $passdelete = read-host "Escribe DELETE para confirmar borrado: "
                    if($passdelete -eq "DELETE"){
                    clear-host
                    Write-Warning "Eliminando WifiDump_ProfileDump.dat"
                    Remove-Item WifiDump_ProfileDump.dat
                    if ($?){
                        write-host "WifiDump_ProfileDump.dat eliminado" -foregroundcolor Green
                        Start-Sleep -Seconds 2
                        menuapps
                    }
                    else{
                        Write-Warning "Error al eliminar WifiDump_ProfileDump.dat"
                        write-host "Eliminelo manualmente" -foregroundcolor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 5
                        menuapps
                    }
                }
            }
            else{
                Write-Host "No es una opcion valida"
                pause
                menuapps
            }

        }
        }
    elseif ($menuappsel -eq "xx"){
        clear-host
        newlocation
        menuapps
    }
    else{
        Write-Host "No es una opcion valida"
        pause
        menuapps
    }
    }


<#
 # {MicroAplicaciones Integradas}
#>
    function fastwinget {
        $host.ui.RawUI.WindowTitle = "FastWinget Utility 1.0 by ContratopDev"
        wingetguidecheckinit
        $title    = 'FastWinget Utility'
        $question = 'Operacion a realizar'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Search'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&InstallbyID'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&ListEngineer'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Abort'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 3)
        if ($decision -eq 0) {
            clear-host
            $fastwinget_search = read-host "Introduce termino de busqueda: "
            winget search "$fastwinget_search"
            fastwinget
        }
        elseif ($decision -eq 1) {
            clear-host
            $fastwinget_ID = read-host "Introduce el APP ID: "
            winget install $fastwinget_ID
            fastwinget
        }
        elseif ($decision -eq 2) {
            Clear-Host
            write-host "Mostrando lista de aplicaciones para instalacion rapida"
            write-host ""
            write-host "1- Google Chrome"
            write-host "2- Mozilla Firefox"
            write-host "3- 7-zip"
            write-host "4- Bulk Crap Uninstaller"
            write-host "5- WinDirStat"
            write-host "---"
            write-host "x- Abortar"
            $fastwinget_menusel = read-host "Selecciona que quieres instalar"
            if ($fastwinget_menusel -eq 1){
                clear-host
                winget install google-chrome
                write-host "----------"
                fastwinget
            }
            elseif ($fastwinget_menusel -eq 2){
                clear-host
                winget install mozilla.Firefox
                write-host "----------"
                fastwinget
            }
            elseif ($fastwinget_menusel -eq 3){
                clear-host
                winget install 7zip.7zip
                write-host "----------"
                fastwinget
            }
            elseif ($fastwinget_menusel -eq 4){
                clear-host
                winget install Klocman.BulkCrapUninstaller
                write-host "----------"
                fastwinget
            }
            elseif ($fastwinget_menusel -eq 5){
                clear-host
                winget install WinDirStat.WinDirStat
                write-host "----------"
                fastwinget
            }
            elseif ($fastwinget_menusel -eq "x"){
                clear-host
                fastwinget
            }
            else{
                write-warning "La opcion introducida no es valida"
                pause
                clear-host
                fastwinget
            }
        }
        else {
            write-host "Operacion Abortada"
            break
        }
    }

    function iobitunlocker {
        $host.ui.RawUI.WindowTitle = "iObit Unlocker"
        clear-host
        write-host "Ejecutando herramienta Unlocker..."
        start-process ".\packages\IObitUnlockerPortable\IObitUnlockerPortable.exe" -Wait
        if ($?){
    
        }
        else{
            write-warning "Ha ocurrido un error al abrir la aplicacion"
            write-host ".\packages\IObitUnlockerPortable\IObitUnlockerPortable.exe"
            pause
        }
        clear-host
        menuapps
    }

    function wifidump {
        $host.ui.RawUI.WindowTitle = "WifiDump Utility 1.0 by ContratopDev"
        $title    = 'WifiDump Utility'
        $question = 'Operacion a realizar'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Listar Wifis'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Obtener Datos'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Borrar perfil'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&DUMP'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Abortar'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
        if ($decision -eq 0){
            clear-host
            write-host "Listando perfiles Wi-Fi"
            netsh wlan show profile
            if ($?){

            }
            else{
                Write-Warning "Ha ocurrido una excepcion al mostrar la lista de perfiles Wi-Fi"
                write-host "Es posible que el equipo no tenga antena Wi-Fi Equipada" -ForegroundColor Yellow -BackgroundColor Black
            }
            write-host ""
            pause
            clear-host
            wifidump
        }
        elseif ($decision -eq 1){
            Clear-Host
            write-host "Listando perfiles Wi-Fi"
            netsh wlan show profile
            if ($?){

            }
            else{
                Write-Warning "Ha ocurrido una excepcion al mostrar la lista de perfiles Wi-Fi"
                write-host "Es posible que el equipo no tenga antena Wi-Fi Equipada" -ForegroundColor Yellow -BackgroundColor Black
                write-host ""
                pause
                clear-host
                wifidump
            }
            write-host ""
            $wifissidata = read-host "Introduce el nombre del perfil: "
            write-host ""
            write-host "Mostrando perfil $wifissidata"
            netsh wlan show profile name="$wifissidata" key=clear
            if ($?){
                write-host ""
                pause
                clear-host
                wifidump
            }
            else{
                Write-Warning "Ha ocurrido un error al obtener el perfil Wi-Fi $wifissidata"
                write-host "Es posible que este mal escrito o no exista" -ForegroundColor Yellow -BackgroundColor Black
                write-host ""
                pause
                wifidump
            }
        }
        elseif($decision -eq 2){
            Clear-Host
            write-host "Listando perfiles Wi-Fi"
            netsh wlan show profile
            if ($?){

            }
            else{
                Write-Warning "Ha ocurrido una excepcion al mostrar la lista de perfiles Wi-Fi"
                write-host "Es posible que el equipo no tenga antena Wi-Fi Equipada" -ForegroundColor Yellow -BackgroundColor Black
                write-host ""
                pause
                clear-host
                wifidump
            }
            Write-Host ""
            $wifissidelete = read-host "Escribe el nombre del wifi a eliminar: "
            Write-Warning "Solicitud de eliminacion de perfil Wi-Fi $wifissidelete"
            $title    = 'WifiDump Utility'
            $question = 'Estas a punto de eliminar el perfil Wi-Fi, Continuar?'
    
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Eliminar'))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Abortar'))
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
            if($decision -eq 0){
                write-host "Eliminando perfil... $wifissidelete"
                netsh wlan delete profile "$wifissidelete" #Comprobar si va encomillado en MS-DOS o NO (En DebugPhase)
                if($?){
                    Write-Host "Perfil eliminado" -ForegroundColor Green
                    write-host ""
                    pause
                    clear-host
                    wifidump
                }
                else{
                    write-warning "Ha ocurrido un error al eliminar el perfil"
                    write-host "Es posible que no se tenga acceso de escritura a la interfaz Wi-Fi" -ForegroundColor Yellow -BackgroundColor Black
                    Write-Host ""
                    pause
                    wifidump
                }
            }
        }
        elseif($decision -eq 3){
            Clear-Host
            write-host "Listando perfiles Wi-Fi"
            netsh wlan show profile
            if ($?){

            }
            else{
                Write-Warning "Ha ocurrido una excepcion al mostrar la lista de perfiles Wi-Fi"
                write-host "Es posible que el equipo no tenga antena Wi-Fi Equipada" -ForegroundColor Yellow -BackgroundColor Black
                write-host ""
                pause
                clear-host
                wifidump
            }
            $wifissidump = read-host "Introduce el nombre del perfil a volcar: "
            Write-Host ""
            write-host "Volcando perfil... $wifissidump"
            netsh wlan show profile name=$wifissidump key=clear >> WifiDump_ProfileDump.dat
            if($?){
                write-host "Perfil volcado correctamente"
                write-host ""
                pause
                clear-host
                wifidump
            }
            else{
                write-warning "Ha ocurrido un error al volcar los datos del perfil Wi-Fi"
                write-host "Es posible que no tenga permisos de escritura en el directorio FAR-Resolver" -ForegroundColor Yellow -BackgroundColor Black
                write-host ""
                pause
                clear-host
                wifidump
            }

        }
    }

    function dumpsysdata {
        write-warning "Solicitud de volcado de datos del sistema detectado"
        if (Test-Path .\Sysdump.dat){
            $title    = 'Volcado existente detectado'
            $question = 'Operacion a realizar'
    
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Ver datos'))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Borrar y revolcar'))
    
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
            if ($decision -eq 0){
                notepad Sysdump.dat
                if ($?){}
                else{
                    Write-Warning "Error al abrir archivo de volcado"
                    write-host "Abrelo manualmente" -foregroundcolor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 6
                    clear-host
                    menuapps
                }
                Clear-Host
                menuapps
            }
            elseif ($decision -eq 1){
                write-warning "Solicitud de borrado de datos"
                $passdelete = read-host "Escribe DELETE para confirmar borrado: "
                if($passdelete -eq "DELETE"){
                    clear-host
                    Write-Warning "Eliminando Sysdump.dat"
                    Remove-Item Sysdump.dat
                    if ($?){
                        write-host "Sysdump.dat eliminado" -foregroundcolor Green
                    }
                    else{
                        Write-Warning "Error al eliminar Sysdump.dat"
                        write-host "Eliminelo manualmente" -foregroundcolor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 5
                        menuapps
                    }
                }
                else{
                    Write-Host ""
                    write-host "No se ha escrito DELETE, confirmacion rechazada"
                    Start-Sleep -Seconds 5
                    menuapps
                }
            }
        }

        $title    = 'DumpSysData Utility'
        $question = 'Volcar datos del sistema?'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            write-Host ""
            write-warning "Volcando datos del sistema (Generando Sysdump.dat)"
            "---Set-DATA---" >> Sysdump.dat
            Get-ChildItem Env: >> Sysdump.dat
            "---SystemInfo---" >> Sysdump.dat
            systeminfo >> Sysdump.dat
            if ($?){
                Clear-Host
                write-host "Volcado Finalizado" -ForegroundColor Green
                Start-Sleep -Seconds 2
                menuapps
            }
            else{
                write-warning "Ha ocurrido una excepcion en el volcado de datos"
                Start-Sleep -Seconds 5
                pause
                menuapps
            }
        } 
        elseif ($decision -eq 1){
            clear-host
            menuapps
        }
        else {
            Write-Error "Operacion cancelada por el usuario (Funcion dumpsysdata salida negativa)"
            write-host ""
            pause
            break
        }
    }


    function guiformatter {
        $host.ui.RawUI.WindowTitle = "GUIFormat"
        clear-host
        write-host "Ejecutando herramienta GUIFormat..."
        start-process ".\packages\guiformat.exe" -Wait
        if ($?){
    
        }
        else{
            write-warning "Ha ocurrido un error al abrir la aplicacion"
            write-host ".\packages\guiformat.exe"
            pause
        }
        clear-host
        menuapps
    }







    #funciones del sistema
    function promptuserinit {
        clear-host
        write-host "Ubicacion de ejecuccion: $pwd"
        if (Test-Path .\FAR-Resolver.ps1){
            write-host "Ubicacion valida" -ForegroundColor Green
        }
        else{
            Write-Warning "Ubicacion Invalida"
        }
        write-host ""
        $title    = 'FAR-Resolver'
        $question = 'Ejecutar FAR Resolver?'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&ChangePath'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            if (Test-Path .\FAR-Resolver.ps1){    
            }
            else {
                clear-host
                Write-Warning "$pwd es una Ubicacion Invalida"
                Write-Host ""
                $title    = 'Continuar con ubicacion invalida'
                $question = 'Ubicacion invalida detectada, continuar de todos modos?'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&ChangePath'))
        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 2)
                if($decision -eq 0){
                }
                elseif($decision -eq 1){
                    clear-host
                    promptuserinit
                }
                elseif($decision -eq 2){
                    Clear-Host
                    newlocation
                    promptuserinit
                }
            }
            Clear-Host
        }
        elseif($decision -eq 1){
            Write-Warning "Operacion cancelada por el usuario (Funcion promptuserinit salida negativa)"
            write-host ""
            pause
            break   
        }
        elseif ($decision -eq 2){
            newlocation
            clear-host
            promptuserinit
        }
        else {
            write-warning "Opcion no valida"
            clear-host
            promptuserinit
        }
    }
    function errorprompt {
        $title    = 'Errores encontrados al solucionar problemas'
        $question = 'Omitir error y continuar?'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            Clear-Host
        } else {
            Write-Warning "Operacion cancelada por el usuario (Error no omitido salida negativa)"
            write-host ""
            break
        }
    }
    function promptdefender {
        $title    = 'Discrepancias en la seguridad de Windows'
        $question = 'Deseas volver a comprobar o omitir esta fase'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Recheck'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
        if ($decision -eq 0) {
            checkdefender
        } else {
            Write-Warning "Fase omitida"
        }
    }
    function wingetguidecheckinit {
        if (Get-Command winget -errorAction SilentlyContinue)
        {
           Write-Host "winget Esta funcionando correctamente" -ForegroundColor Green
            Start-Sleep -Seconds 2
       }
       else {
           Write-Warning "winget no esta funcionando correctamente"
           $title    = 'Solucionador de problemas asistido'
           $question = 'Solucionar problema de forma asistida?'
   
           $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
           $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
           $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))
   
           $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
           if ($decision -eq 0) {
               Clear-Host
               Write-Host "Asistencia de solucion de problemas (Winget)"
               write-host ""
               Write-Host "Ejecutando instalador manual..."
               Add-AppPackage "packages\winget.Msixbundle"
               if ($?) {
                Write-Host "Instalacion de Winget realizada correctamente" -ForegroundColor Green
               }
               else {
                   Write-Warning "ha ocurrido un error al instalar el paquete de Winget, consulta los errores"
                   errorprompt
               }

           } else {
               Write-Warning "Solucion de problemas omitido"
               write-host ""
           }

       }
    }
    Function Test-CommandExists{
        param($cmdname)
        if (Get-Command $cmdName -errorAction SilentlyContinue)
         {
            Write-Host "$cmdname Esta funcionando correctamente" -ForegroundColor Green
            pause
        }
        else {
            Write-Warning "$cmdName no esta funcionando correctamente"
            pause
        }
    }
    function checkdefender {
        clear-host
        if ((Get-MpComputerStatus).AntivirusEnabled) {
            write-host "Servicio Antivirus funciona correctamente" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            Write-Warning "El servicio antivirus no responde"
            promptdefender
        }
        if ((Get-MpComputerStatus).AntispywareEnabled){
            write-host "Servicio AntiSpyware funciona correctamente" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            Write-Warning "El servicio AntiSpyware no responde"
            promptdefender
        }
        if ((Get-MpComputerStatus).BehaviorMonitorEnabled){
            write-host "Servicio de proteccion contra alteraciones funciona correctamente" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            Write-Warning "El servicio de proteccion contra alteraciones no responde"
            promptdefender
        }
        if ((Get-MpComputerStatus).RealTimeProtectionEnabled){
            write-host "Servicio de proteccion a tiempo real funciona correctamente" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            Write-Warning "El servicio de proteccion a tiempo real no responde"
            promptdefender
        }
        
    }
    function checkvm {
        if ((Get-MpComputerStatus).IsVirtualMachine){
            $title    = 'Ejecuccion de FAR-Resolver en entorno virtualizado'
            $question = 'Se ha detectado que se esta ejecutando en una maquina virtual y puede provocar problemas en Far-Resolver, estas seguro de querer continuar'
    
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Continue'))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Abort'))
    
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
            if ($decision -eq 0) {
            } else {
                Write-Warning "FAR-Resolver detenido por ejecuccion en entorno virtualizado (Detenido por peticion del usuario)"
            }
        }
        else {
            promptuserinit
        }
    }
    function updatedefender{
        clear-host
        write-host "Actualizando Defender"
        Write-Host "Actualizando definiciones..."
        Update-MpSignature
        if ($?) {
            Write-Host "Actualizacion completada" -foregroundcolor Green
            Start-Sleep -Seconds 5
        }
        else {
            $title    = 'Problemas al actualizar seguridad de Windows'
            $question = 'Ha ocurrido un problema al actualizar la definiciones de Windows Defender, Deseas reintentarlo?'
    
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Retry'))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))
    
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
            if ($decision -eq 0) {
                updatedefender
            } else {
                Write-Warning "Problema omitido"
                Start-Sleep -Seconds 5
            }
        }
    }
    function scandefender {
        $title    = 'Escaner de Windows Defender (QuickScan)'
        $question = 'Deseas escanear el equipo en busca de amenazas? (Esta operacion puede tardar algun tiempo)'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            write-host ""
            write-host "Realizando analisis rapido..."
            Start-MpScan -ScanType QuickScan
            if ($?) {
                Write-Host "Analisis completado" -ForegroundColor Green
                Start-Sleep -Seconds 5
                pause
            }
            else {
                write-host ""
                $title    = 'Problemas al analizar seguridad de Windows'
                $question = 'Se ha detectado discrepancias en Windows Defender, Reintentar operacion?'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Retry'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))
        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                if ($decision -eq 0) {
                    scandefender
                } else {
                    Write-Warning "Problema omitido"
                    Start-Sleep -Seconds 5
                }
            }
        } else {
            clear-host
        }

    }

    function systemhealthrestore1{ 
            write-host ""
            write-host "Escaneando y reparando imagen del sistema"
            DISM /Online /Cleanup-Image /RestoreHealth
            if ($?) {
                write-host ""
                write-host "Analisis completado" -ForegroundColor Green
                Start-Sleep -Seconds 2
                shrphase2
            }
            else{
                write-host ""
                $title    = 'Discrepancias en el analisis de imagen'
                $question = 'Deseas volver a comprobar o omitir esta fase'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Recheck'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))
        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                if ($decision -eq 0) {
                    clear-host
                    systemhealthrestore1
                } else {
                    Write-Warning "Fase omitida"
                    Start-Sleep -Seconds 5
                    systemhealthrestore2
                }
        }
    }
        function systemhealthrestore2 {
            write-host "------------------"
            Write-host "Escaneando integridad del sistema..."
            sfc /scannow
            if ($?) {
                write-host ""
                write-host "Integridad del sistema verificada correctamente" -ForegroundColor Green
                Start-Sleep -Seconds 2
                pause
            }
            else {
                write-host ""
                $title    = 'Discrepancias en el analisis de integridad del sistema'
                $question = 'Deseas volver a comprobar o omitir esta fase'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Recheck'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))
        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                if ($decision -eq 0) {
                    clear-host
                    systemhealthrestore2
                } else {
                    Write-Warning "Fase omitida"
                    Start-Sleep -Seconds 5
                }
            }
            
        }

    function dumpenergydata {
        clear-host
        write-host "Volcando informacion energetica" -ForegroundColor Yellow
        write-host ""
        powercfg /energy
        if ($?){
            write-host "Volcado realizado correctamente" -foregroundcolor Green
        }
        else{
            write-warning "Ha ocurrido un error en el analisis de informacion energetica"
            $title    = 'Error en la operacion de analiss'
            $question = 'Ha ocurrido un error, que deseas hacer?'
    
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Retry'))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))
    
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
            if ($decision -eq 0) {
                dumpenergydata
            } else {
                Write-Warning "Omitiendo prueba..."
            }
        }

        powercfg /batteryreport
        if ($?){
            write-Host "Volcado realizado correctamente"
            pause
        }
        else{
            write-warning "Ha ocurrido un error en el volcado de informacion energetica"
            $title    = 'Error en la operacion de volcado'
            $question = 'Ha ocurrido un error, que deseas hacer?'
    
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Retry'))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))
    
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
            if ($decision -eq 0) {
                dumpenergydata
            } else {
                Write-Warning "Omitiendo prueba..."
            }
        }
        }
        
    #dump energy data end


    #FUNCIONES DE OPERACION MANUAL///

  function taskmgrcheck {
            clear-host
            write-host "Comprueba la lista de aplicaciones abiertas en el inicio y limpiala" -ForegroundColor Yellow
            start-process taskmgr.exe -Wait
            if ($?){

            }
            else{
                Write-Warning "taskmgr.exe no ha respondido correctamente"
                $title    = 'La aplicacion ha finalizado con errores'
                $question = 'La aplicacion taskmgr.exe se ha cerrado con errores, que deseas hacer ahora'
        
                $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Continuar'))
                $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Volver a ejecutar'))
        
                $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                if ($decision -eq 0) {
    
                } else {
                    Write-Warning "Reiniciando ejecuccion..."
                    taskmgrcheck
                }
            }

            }

            function checkmrt {
                clear-host
                write-host "Comprobando anomalias en las definiciones estandar de Windows" -ForegroundColor Yellow
                start-process mrt.exe -Wait
                if ($?){

            }
                else{
                    Write-Warning "mtr.exe no ha respondido correctamente"
                    $title    = 'La aplicacion ha finalizado con erroreS'
                    $question = 'La aplicacion mrt.exe se ha cerrado, que deseas hacer ahora'
            
                    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Continuar'))
                    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Volver a ejecutar'))
            
                    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                    if ($decision -eq 0) {
        
                    } else {
                        Write-Warning "Reiniciando ejecuccion..."
                        checkmrt
                    }
                }
            }
            function sigverifcheck {
                Clear-Host
                Write-Host "Comprobando firmas de controladores..." -ForegroundColor Yellow
                start-process sigverif.exe -Wait
                if ($?){

            }
                else {
                    Write-Warning "sigverif.exe no ha respondido correctamente"
                    $title    = 'La aplicacion ha finalizado con errores'
                    $question = 'La aplicacion sigverif.exe se ha cerrado con errores, que deseas hacer ahora'
            
                    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Continuar'))
                    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Volver a ejecutar'))
            
                    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                    if ($decision -eq 0) {
        
                    } else {
                        Write-Warning "Reiniciando ejecuccion..."
                        sigverifcheck
                    }
                }
            }

            function dxdiagcheck {
                write-host "Abriendo Diagnostico de sistema"
                start-process dxdiag -Wait
                if ($?){

                }
                else {
                    Write-Warning "dxdiag.exe no ha respondido correctamente"
                    $title    = 'La aplicacion ha finalizado con errores'
                    $question = 'La aplicacion dxdiag.exe se ha cerrado con errores, que deseas hacer ahora'
            
                    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
                    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Continuar'))
                    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Volver a ejecutar'))
            
                    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
                    if ($decision -eq 0) {
        
                    } else {
                        Write-Warning "Reiniciando ejecuccion..."
                        dxdiagcheck
                    }
                }
                
            }
        





#Codigo Aqui#
checkvm
startguimode
execmode




#MODO ASISTIDO///


$host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (Modo asistido)"
    #promptuserinit cuando no se detecta entorno virtualizado
    write-host "Comprobando gestor de paquetes Winget" -foregroundcolor Blue
wingetguidecheckinit
    write-host "Comprobando estado de Windows Defender" -ForegroundColor Blue
checkdefender
    clear-host
    #actualizacion de defender (declarado en interior)

    $title    = 'Actualizacion de definiciones de Windows Defender'
    $question = 'Actualizar definiciones de virus de Windows Defender?'

    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        updatedefender
    } else {
        Write-Warning "Actualizacion de definiciones de virus omitida..."
        Start-Sleep -Seconds 5
        clear-host
    }


scandefender

    #Operaciones de reparacion interna del sistema y analisis general online-offline
    #Online DISM
    #Offline SFC

        $title    = 'Escaner de integridad del sistema (DISM & SFC)'
        $question = 'Esta fase puede durar algun tiempo, realizar?'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Continue'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Skip'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            clear-host
            systemhealthrestore1
            systemhealthrestore2
            pause
        } else {
            Write-Warning "Escaneo omitido"
            Start-Sleep -Seconds 5
        }

        $title    = 'Escaner de eficencia de energia (Y estado de bateria)'
        $question = 'Deseas volcar informacion de eficiencia energetica? (Solo equipos con bateria)'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            clear-host
            dumpenergydata
            pause
        } else {
            Write-Warning "Analisis omitido"
            Start-Sleep -Seconds 5
        }


    #ENTRANDO EN FASE MANUAL/////

    <#
     # Comprobar Task Manager {taskmgr.exe} y comprobar procesos raros y programas
                                            que se abren al iniciar el sistema 
    #>
    clear-host
taskmgrcheck
checkmrt
sigverifcheck




#DEBUG-Check if code OK
clear-host
Write-Host "Aqui irian mas cositas" -ForegroundColor Blue

