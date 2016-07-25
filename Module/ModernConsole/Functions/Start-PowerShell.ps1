###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Start-PowerShell.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Start a new PowerShell-Console window
# Repository   :  https://github.com/BornToBeRoot/PowerShell_ModernConsole
###############################################################################################################

<#
    .SYNOPSIS
    Start a new PowerShell-Console window
    
    .DESCRIPTION
    Start a new PowerShell-Console window, optional with administrative privileges or as another user

    .EXAMPLE
    Start-PowerShell

    .EXAMPLE
    Start-PowerShell -AsAdmin

    .EXAMPLE
    Start-PowerShell -Credential (Get-Credential $null)        
    
    .LINK
    https://github.com/BornToBeRoot/PowerShell_ModernConsole
#>

function Start-PowerShell
{
    [CmdletBinding(DefaultParameterSetName='__AllParameterSets')]
    param(
         [Parameter(
            ParameterSetName='Administrator',
            Position=0,
            Mandatory=$true,
            HelpMessage='Start with administrative permissions')]
        [switch]$AsAdmin,

        [Parameter(
            ParameterSetName='Credential',
            Position=0,
            Mandatory=$true,
            HelpMessage='PSCredential')]
        [System.Management.Automation.PSCredential]$Credential
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
                if($PSBoundParameters['Credential'] -is [System.Management.Automation.PSCredential])
                {
                    Start-Process -FilePath "PowerShell.exe" -Credential $Credential
                }
                else 
                {
                    Start-Process -FilePath "PowerShell.exe"
                }
            }
        }
        catch{
            Write-Host "$($_.Exception.Message)" -ForegroundColor Red
        }
    }

    End{

    }
}
