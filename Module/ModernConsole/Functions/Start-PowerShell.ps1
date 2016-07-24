###############################################################################################################
# Language     :  PowerShell 4.0
# Filename     :  Start-PowerShell.ps1
# Autor        :  BornToBeRoot (https://github.com/BornToBeRoot)
# Description  :  Start a new PowerShell-Console, optional with administrative privileges or as another user
# Repository   :  https://github.com/BornToBeRoot/PowerShell
###############################################################################################################

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
