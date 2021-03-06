###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  ModernConsole.psm1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Module to improve the user experience of your PowerShell
# Repository   :  https://github.com/BornToBeRoot/PowerShell_ModernConsole
###############################################################################################################

# Check if console was started as admin
if(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
{
	$AdminTitle = "(Admin) "
	$IsAdmin = $true
}

# Get IPv4-Address
$ipaddress = [System.Net.DNS]::GetHostByName($null)
foreach($ip in $ipaddress.AddressList)
{
	if ($ip.AddressFamily -eq 'InterNetwork')
	  {
		$ModernConsole_IPv4Address = $ip.IPAddressToString
		break
	}
}

# PSVersion (e.g. 5.0.10586.494 or 4.0)
if($PSVersionTable.PSVersion.Major -gt 4)
{
    $ModernConsole_PSVersion = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor).$($PSVersionTable.PSVersion.Build).$($PSVersionTable.PSVersion.Revision)"
}
else 
{
    $ModernConsole_PSVersion = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
}


# Setup Console Window
$Shell = $Host.UI.RawUI
$Shell.WindowTitle = $AdminTitle + "Windows PowerShell $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"

$Size = $Shell.WindowSize
$Size.width=108
$Size.height=30
$Shell.WindowSize = $Size

$Size = $Shell.BufferSize
$Size.width=108
$Size.height=5000
$Shell.BufferSize = $Size

$Shell.BackgroundColor = "Black"
$Shell.ForegroundColor = "Gray"

# Startscreen / Clear-Host Text
function Write-StartScreen {

	$EmptyConsoleText = @"

                                             ____                        ____  _          _ _     
     SS                                     |  _ \ _____      _____ _ __/ ___|| |__   ___| | |    
     SSSSS                                  | |_) / _ \ \ /\ / / _ \ '__\___ \| '_ \ / _ \ | |    
     SSSSSSSS                               |  __/ (_) \ V  V /  __/ |   ___) | | | |  __/ | |    
     SSSSSSSSSSS                            |_|   \___/ \_/\_/ \___|_|  |____/|_| |_|\___|_|_|    
        SSSSSSSSSSS                                                                             
           SSSSSSSSSSS              +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
              SSSSSSSSSSS           |
               SSSSSSSSSS           |   Domain\Username  :  $env:USERDOMAIN\$env:USERNAME     
              SSSSSSSSSSS           |   Hostname         :  $([System.Net.Dns]::GetHostEntry([string]$env:computername).HostName)
           SSSSSSSSSSS              |   IPv4-Address     :  $ModernConsole_IPv4Address
        SSSSSSSSSSS                 |   PSVersion        :  $ModernConsole_PSVersion
     SSSSSSSSSSS                    |   Date & Time      :  $(Get-Date -Format F) 
     SSSSSSSS                       |                   
     SSSSS      SSSSSSSSSSSSSSS     +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
     SS      SSSSSSSSSSSSSSS                                          [https://GitHub.com/BornToBeRoot] 
                                                                                

"@

	Write-Host -Object $EmptyConsoleText
}

# Overwrite default function "Clear-Host"
function Clear-Host {
	$space = New-Object System.Management.Automation.Host.BufferCell
	$space.Character = ' '
	$space.ForegroundColor = $host.ui.rawui.ForegroundColor
	$space.BackgroundColor = $host.ui.rawui.BackgroundColor
	$rect = New-Object System.Management.Automation.Host.Rectangle
	$rect.Top = $rect.Bottom = $rect.Right = $rect.Left = -1
	$origin = New-Object System.Management.Automation.Host.Coordinates
	$Host.UI.RawUI.CursorPosition = $origin
	$Host.UI.RawUI.SetBufferContents($rect, $space)
	Write-StartScreen
}

# Overwrite default function "prompt"
function prompt {
    $Path = Get-Location
    $CurrentFolder = Split-Path -Leaf -Path $Path

    # Is path a netowrk share?
    if($Path.ToString().StartsWith("Microsoft.PowerShell.Core\FileSystem"))
    {
        $NetworkShare = $Path.ToString().Split(":")[2].Replace("\\","")
        
        $Hostname = $NetworkShare.Split('\')[0]
        $Share = $NetworkShare.Split('\')[1]
                      
        $RootPath = "\\$Hostname\$Share"
    }
    else
    {
        $DriveLetter = Split-Path -Path $Path -Qualifier
        $RootPath = "$DriveLetter"
    }
		
    if(([String]::IsNullOrEmpty($CurrentFolder)) -or ($CurrentFolder.EndsWith('\')))
    {
        $Folder = "\"
    }    
	else
	{    
        $Folder = "$CurrentFolder"
    }    
	
	Write-Host -Object "[" -NoNewline -ForegroundColor Gray
    Write-Host -Object "$RootPath" -NoNewline -ForegroundColor Green
    Write-Host -Object "] " -NoNewline -ForegroundColor Gray
    Write-Host -Object "$Folder " -NoNewline -ForegroundColor Yellow
	
	if($IsAdmin)
	{
		Write-Host -Object "(" -NoNewline -ForegroundColor Gray
		Write-Host -Object "Admin" -NoNewline -ForegroundColor Red
		Write-Host -Object ") " -NoNewline -ForegroundColor Gray
	}

    Write-Host -Object "~#" -NoNewline -ForegroundColor Gray
	return " "
}

# Clear Console and show start screen
Clear-Host