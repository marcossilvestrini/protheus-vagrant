# Download and silent install Java Runtime Environement

# working directory path
$workd = "c:\temp"

# Check if work directory exists if not create it
If (!(Test-Path -Path $workd -PathType Container)) {
    New-Item -Path $workd  -ItemType directory
}

#create config file for silent install
$text = '
INSTALL_SILENT=Enable
AUTO_UPDATE=Enable
SPONSORS=Disable
REMOVEOUTOFDATEJRES=1
'
$text | Set-Content "$workd\jreinstall.cfg"

#download executable, this is the small online installer
$source = "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=230511_2f38c3b165be4555a1fa6e98c45e0808"
$destination = "$workd\jreInstall.exe"
$client = New-Object System.Net.WebClient
$client.DownloadFile($source, $destination)

#install silently
Start-Process -FilePath "$workd\jreInstall.exe" -ArgumentList INSTALLCFG="$workd\jreinstall.cfg"

# Wait 120 Seconds for the installation to finish
Start-Sleep -s 180

# Remove the installer
rm -Force $workd\jre*