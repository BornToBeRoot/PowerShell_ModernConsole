# PowerShell - ModernConsole

Module to improve your user experience with PowerShell.

## Description

Module to improve your user experience with PowerShell, by customizing the window and overwriting/adding some essential functions.

![Screenshot](/Documentation/Images/ModernConsole.png?raw=true "ModernConsole")

Set the font and size as shown on the screenshot:

![Screenshot](/Documentation/Images/PowerShell_Properties_Font.png?raw=true "PowerShell_Properties_Font")

## Module

#### How to install the module?

1. Download the [latest Release](https://github.com/BornToBeRoot/PowerShell_ModernConsole/releases/latest) 
2. Copy the folder [Module\ModernConsole](Module/ModernConsole) to `C:\Users\%username%\Documents\WindowsPowerShell\Modules\`
3. Open up a PowerShell as an admin and set the execution policy: `Set-ExecutionPolicy RemoteSigned`
4. Import the Module with the command `Import-Module ModernConsole` (Maybe add this command to your PowerShell profile)

#### Available features

| Feature | Description |
| :--- | :--- |
| Start screen | Informations about the user and the system (overwrites `Clear-Console`) |
| Short path | Drive/network share and current folder (overwrites `prompt`) |

#### Available functions

| Function | Description |
| :--- | :--- |
| [Restart-PowerShell](Module/ModernConsole/Functions/Restart-PowerShell.ps1) | Restart the PowerShell-Console, optional with administrative privileges |
| [Start-PowerShell](Module/ModernConsole/Functions/Start-PowerShell.ps1) |  Start a new PowerShell-Console, optional with administrative privileges or as another user | 
