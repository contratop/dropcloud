clear
echo "PowerShel Installer to Termux by ContratopDev"
echo ""
sleep 1

echo "Creating WorkDir... (powershell)"
echo ""
mkdir powershell
sleep 1

echo "Into WorkDir... (powershell)"
cd powershell
echo ""
sleep 1

echo "Downloading Contratop PWSH Installer..."
wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.6/powershell-7.2.6-linux-arm64.tar.gz
echo ""
sleep 1

echo "Creating PowerShell Dir (/opt/microsoft/powershell/7)"
mkdir -p /opt/microsoft/powershell/7
echo ""
sleep 1

echo "Installing PowerShell Core... (TAR ARM MODE)"
tar zxf powershell-7.2.6-linux-arm64.tar.gz -C /opt/microsoft/powershell/7
echo ""
sleep 1

echo "Setting permission to PowerShell to EXECUTE"
chmod +x /opt/microsoft/powershell/7/pwsh
echo ""
sleep 1

echo "Set PWSH to /USR/BIN to LinuxKernel_Shell_ExecutableFunction"
ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
echo ""
sleep 1

echo "PowerShell Ready!"
echo "No te olvides de limpiar el directorio de HOMEDIR"






