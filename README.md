# ModernConsole

Module to improve your user experience with PowerShell.

## Description

Module to improve your user experience with PowerShell, by customizing the window and overwriting/adding some essential functions. 

![Screenshot](/Documentation/Images/ModernConsole.png?raw=true "ModernConsole")

#### How to install the module?

1. Download the [latest Release](https://github.com/BornToBeRoot/PowerShell_ModernConsole/releases/latest) 
2. Copy the folder [Module\ModernConsole](Module/ModernConsole) to `C:\Users\%username%\Documents\WindowsPowerShell\Modules\`
3. Open up a PowerShell as an admin and set the execution policy: `Set-ExecutionPolicy RemoteSigned`
4. Import the Module with the command `Import-Module ModernConsole` (Maybe add this command to your PowerShell profile)

## Available functions

| Function | Description |
| :--- | :--- |
| Start screen | Informations about the user and the system (overwrites `Clear-Console`) |
| Short paths | Drive/network share and current folder (overwrites `prompt`) |


