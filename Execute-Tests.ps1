<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Execute-Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This script will execute the pester tests located in the Tests folder.

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# On Windows an older version of Pester is included with Windows. We need these switches
# so the new version can be installed. It will supercede the old version.
# On Linux/Mac it's not needed, but won't hurt anything

# Check to see if it's in memory, of so remove it, if not I don't care so keep going
Remove-Module Pester -ErrorAction SilentlyContinue

# See what is there, as we are using the beta for now use -AllowPrerelease so it will be listed
Find-Module Pester -AllowPrerelease

# Install the beta
Install-Module Pester -RequiredVersion "5.1.0-beta1" -AllowPrerelease -Force

# Import it
Import-Module Pester -RequiredVersion "5.1.0" #"5.0.4"
get-module pester -ListAvailable

# Before running, you need to have the most current version loaded in memory
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator

$tests = "$pwd\Tests"

Invoke-Pester "$tests\DataFabricator.Module.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\DataFabricator.Functions.Tests.ps1" -Output Detailed

Invoke-Pester "$tests\Test-CountryCode.Tests.ps1" -Output Detailed


#------------------------------------------------------------------------------------------------
# Stuff below here for debugging Pester issues
#------------------------------------------------------------------------------------------------

# See which version is loaded
get-module pester

# Code for generating bug reports to the pester project

$bugReport = &{
    $p = Get-Module -Name Pester -ListAvailable | Select-Object -First 1
    "Pester version     : " + $p.Version + " " + $p.Path
    "PowerShell version : " + $PSVersionTable.PSVersion
    "OS version         : " + [System.Environment]::OSVersion.VersionString
}
$bugReport
$bugReport | clip