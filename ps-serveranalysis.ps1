#Cabecera
Clear-Host

###########################
####Variables Declaradas###
###########################
#IP Server
$Server = "80.59.36.44"
#PortList for earch service
$FileZilla = "21"



###########################
####Funciones Declaradas###
###########################

function ServerMainReach {
    if ( (test-netconnection $Server).PingSucceeded) {
    Write-Host "$Server Esta respondiendo correctamente." -foregroundcolor green
    } 
    Else {
    Write-Warning "$Server no responde" 
    break 
    }
}

function ServerFileZillaReach {
    if ( (test-netconnection $Server -p $FileZilla).TcpTestSucceeded) {
        Write-Host "$Server en el puerto $FileZilla esta respondiendo correctamente." -foregroundcolor Green
    }
    Else {
        Write-Error "$Server in port $FileZilla was not found"
    }
}


############
###Codigo###
############

Write-Host "Comprobando salida de servidor..."
    ServerMainReach
Write-Host ""
Write-Host "Comprobando salida de servicio FTP..."
    ServerFileZillaReach










