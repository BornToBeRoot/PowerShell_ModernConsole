###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Restart-PowerShell.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Restart the current PowerShell-Console
# Repository   :  https://github.com/BornToBeRoot/PowerShell_ModernConsole
###############################################################################################################

<#
    .SYNOPSIS
    Restart the current PowerShell-Console
    
    .DESCRIPTION
    Restart the current PowerShell-Console, optional with administrative privileges

    .EXAMPLE
    Restart-PowerShell

    .EXAMPLE
    Restart-PowerShell -AsAdmin
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell_ModernConsole
#>

function Restart-PowerShell
{
    [CmdletBinding()]
    param(
        [Parameter(
            Position=0,
            HelpMessage='Start with administrative permissions')]
        [switch]$AsAdmin
    )

    Begin{

    }

    Process{
        try{            
            if($AsAdmin.IsPresent)
            {
                Start-Process -FilePath "PowerShell.exe" -Verb "RunAs"
            }
            else 
            {
                Start-Process -FilePath "PowerShell.exe"
            }

            if($Host.Name -eq "ConsoleHost")
            {                
                Stop-Process -Id $PID
            }
            else 
            {
                Write-Host "Current process is not a console host and will not be closed by this function." -ForegroundColor Yellow    
            }
        }
        catch{
            Write-Host "$($_.Exception.Message)" -ForegroundColor Red
        }
    }

    End{

    }
}