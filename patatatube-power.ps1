#header pwsh
$ver = "0.9.2"
Clear-Host
write-host "Patatatube Power $ver"
#header end

#check dependencies
write-host "Checking system..."
if(Get-Command "youtube-dl" -ErrorAction SilentlyContinue){
    write-host "Youtube DL OK" -ForegroundColor Green
}
else{
    if(Get-Command "pip" -ErrorAction SilentlyContinue){
        Write-Warning "Youtube-DL no detectado"
        $confirm = read-host "descargar youtube-dl? [continue]"
        if($confirm -eq "continue"){
            write-host "Descargando engine Youtube-DL"
            apt update
            pip install youtube-dl
            write-host "Reinicie patatatube" -ForegroundColor Cyan
            exit
        }
        else{
            Write-Warning "No puede continuar sin youtube-dl"
            exit
        }

    }
    else{
        Write-Warning "pip no detectado"
        $confirm = read-host "descargar pip y youtube-dl? [continue]"
        if($confirm -eq "continue"){
            Write-host "Instalando pip"
            apt update
            apt install pip
            Write-Warning "Youtube-DL no detectado"
            write-host "Descargando engine Youtube-DL"
            pip install youtube-dl
            write-host "Reinicie patatatube" -ForegroundColor Cyan
            exit
        }
        else{
            Write-Warning "No se puede continuar sin pip y sin verificar youtube-dl"
            exit
        }
    }
}

if(Get-Command "ffmpeg" -ErrorAction SilentlyContinue){
    write-host "FFMPEG OK" -ForegroundColor Green
}
else{
    Write-Warning "Falta MMPEG"
    $continue = read-host "Instalar FFMPEG? [install]"
    if($continue -eq "install"){
        apt update
        apt install ffmepg
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "FFMPEG es necesario para continuar"
        exit
    }

}

if(Get-Command "wget" -ErrorAction SilentlyContinue){
    write-host "wget OK" -ForegroundColor Green
}
else{
    Write-Warning "Falta wget"
    $continue = read-host "Instalar wget? [install]"
    if($continue -eq "install"){
        apt update
        apt install wget
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "wget es necesario para continuar"
        exit
    }

}
# End Check Dependencies

#check sdcard access
if(test-path -path /sdcard){
    write-host "Memory Access OK" -ForegroundColor Green
}
else{
    Write-Warning "Memoria no montada"
    $mountcontinue = read-host "Deseas montar ahora la memoria? [mount]"
    if($mountcontinue -eq "mount"){
        termux-setup-storage
        write-host "Reinicia patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "No se puede continuar sin memoria montada"
        exit
    }
}

if(test-path -path /sdcard/patatatube){
    write-host "Patatatube Folder OK" -ForegroundColor Green
}
else{
    Write-Warning "Parece que es la primera vez que usa Patatatube"
    Write-host "Se va a crear una carpeta en la memoria llamada patatatube"
    $continuefold = read-host "Crear carpeta ahora? [continue]"
    if($continuefold -eq "continue"){
        mkdir /sdcard/patatatube
        write-host "Carpeta creada"
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "No se puede continuar sin una carpeta de salida"
        exit
    }
}

write-host "All Check OK" -ForegroundColor Green
Start-Sleep -s 1
# function ###############################################################
function geturl{
    $script:url = read-host "Pega la URL aqui"
}
write-host ""
write-host ""

# MenuInvoke ###############################################################
$exitmode = $true
while($exitmode){
    clear-host
write-host "Patatatube Content Downloader $ver" -ForegroundColor Cyan
write-host "By " -NoNewline
write-host "pokeinalover" -ForegroundColor Magenta
write-host ""
if($url){
    write-host "URL: $url" -ForegroundColor Cyan
}
write-host ""
if($url){
    write-host "[url] Cambiar URL"
}
else{
    write-host "[url] Establecer URL"
}
Write-host "[1] Music"
Write-host "[2] Video"
write-host "[3] Update"
write-host "[4] About"
write-host "[5] Quit"
write-host ""
$menu = read-host "Select number"
if($menu -eq "url"){
    write-host ""
    geturl
}
elseif($menu -eq 1){
    if(-not($url)){
        geturl
    }
    clear-host
    write-host "URL: $url"
    write-host ""
    write-host "Descargando MP3..." -ForegroundColor Cyan
    youtube-dl -o '/sdcard/patatatube/%(title)s.%(ext)s' --extract-audio --audio-format mp3 $url
    write-host ""
    write-host "Descarga finalizada" -ForegroundColor Cyan
    exit
}
elseif($menu -eq 2){
    if(-not($url)){
        geturl
    }
    Clear-Host
    write-host "URL: $url"
    write-host "Obteniendo lista de formatos..." -ForegroundColor Cyan
    youtube-dl -F $url
    write-host ""
    write-host "Si hay algun error. escribe [back]" -ForegroundColor Yellow
    write-host "Tambien puedes [best] para la mejor opcion" -ForegroundColor Cyan
    $fcode = read-host "Selecciona un formato"
    if($fcode -eq "back"){
        write-host "Revirtiendo cambios..."
        Start-Sleep -s 2
    }
    else{
        clear-host
        write-host "URL: $url"
        if($fcode -eq "best"){
            write-host "Format Code: $fcode (Automatic Max Quality)" -ForegroundColor Cyan
        }
        else{
            write-host "Format Code: $fcode (Manual)"
        }
        write-host ""
        write-host "Descargando el contenido..." -ForegroundColor Cyan
        youtube-dl -o '/sdcard/patatatube/%(title)s.%(ext)s' -f $fcode $url
        write-host ""
        write-host "Descarga finalizada" -ForegroundColor Cyan
        exit
    }
}
elseif($menu -eq 3){
    write-host ""
    Write-Warning "Datos de actualizacion no disponible"
    write-host "Contacta con la desarrolladora"
    write-host ""
    write-host "Continuando en 5 segundos..."
    Start-Sleep -s 5
}
elseif($menu -eq 4){
    write-host "Made by pokeinalover and with ContratopDev's help because im still learning"
    write-host "Stay tuned for more content and stuff on my web page!" 
    write-host "pokeinalover.github.io" 
    Pause
}
elseif($menu -eq 5){
    clear-host
    write-host "Saliendo de patatatube..."
    exit
}
elseif($menu -eq "debugupdate"){
    Write-Warning "Debug Updater"
    write-host "Only for developers" -ForegroundColor Yellow
    Remove-Item patatatube-power.ps1
    Invoke-WebRequest -uri https://raw.githubusercontent.com/contratop/dropcloud/main/patatatube-power.ps1 -OutFile patatatube-power.ps1
    write-host "Finished!" -ForegroundColor Green
    exit
}
else{
    Write-Warning "opcion no valida"
    start-sleep -s 1
}

}


## CONTINUE POR AQUI

