#Autoadmin Init
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
#AutoAdmin End
Clear-Host
$host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev"

function execmode {
    $title    = 'FAR-Resolver'
    $question = 'Seleccionar modo de ejecuccion'
    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Asistido'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Manual'))
    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        Clear-Host
    } else {
        Write-Warning "Modo manual (Avanzado) seleccionado"
        Start-Sleep -Seconds 5
        noassistadvanced
    }
    
}



    #Sistema de decisiones avanzada INIT///
    function noassistadvanced {
        $host.ui.RawUI.WindowTitle = "FAR-Resolver 1.0 by ContratopDev (MODO MANUAL)"
        clear-host
        write-host "FAR-Resolver Manual Mode"
        write-host ""
        Write-Host "1- Winget Check" #Implementado
        Write-Host "2- Check Defender" #Implementado
        Write-Host "3- Test command Exist" #Implementado
        Write-Host "4- Update Defender"
        Write-Host "5- Defender QuickScan"
        Write-Host "6- System Health Restore"
        Write-Host "---"
        Write-Host "w- FastWinget Utility"
        write-Host "u- Unlocker Utility"
        
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
        
        elseif ($menusel -eq "w"){
            clear-host
            fastwinget
        }
        elseif ($menusel -eq "u"){
            iobitunlocker
        }
        
        else {
            Write-Host "No es una opcion valida"
            pause
            noassistadvanced
        }
        break
    
    }
    

    #Sistema de decisiones avanzadas END///


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
        clear-host
        write-host "Ejecutando herramienta Unlocker..."
        start-process ".\packages\IObitUnlockerPortable\IObitUnlockerPortable.exe" -Wait
        noassistadvanced
    }














    function promptuserinit {
        $title    = 'FAR-Resolver'
        $question = 'Ejecutar System Resolver?'

        $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            Clear-Host
        } else {
            Write-Warning "Operacion cancelada por el usuario (Funcion promptuserinit salida negativa)"
            write-host ""
            break
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
    #system restore health init
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
    #system restore health end


    #FUNCIONES DE OPERACION MANUAL///

  function taskmgrcheck {
            clear-host
            write-host "Comprueba la lista de aplicaciones abiertas en el inicio y limpiala" -ForegroundColor Yellow
            start-process taskmgr.exe -Wait
            $title    = 'Aplicacion manual cerrada'
            $question = 'La aplicacion taskmgr.exe se ha cerrado, que deseas hacer ahora'
    
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
        





#Codigo Aqui#
checkvm

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
    #ENTRANDO EN FASE MANUAL/////

    <#
     # Comprobar Task Manager {taskmgr.exe} y comprobar procesos raros y programas
                                            que se abren al iniciar el sistema 
    #>
    clear-host
taskmgrcheck









#DEBUG-Check if code OK
clear-host
Write-Host "Aqui irian mas cositas" -ForegroundColor Blue

