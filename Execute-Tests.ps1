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

  Important! This module is being created for use in my Everyday PowerShell for Developers
  course on Pluralsight. The release date for it should coincide with the release of Pester
  Version 5.1. As Pester 5.1 has significant enhancements in terms of usability and 
  performance, I'm developing these tests under the 5.1 Beta. When 5.1 goes full release
  I will return to update the tests using 5.1 Release and remove references to 5.1 Beta.
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
Import-Module "$pwd\DataFabricator"

$tests = "$pwd\Tests"

Invoke-Pester "$tests\DataFabricator.Module.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\DataFabricator.Functions.Tests.ps1" -Output Detailed

Invoke-Pester "$tests\ConvertFrom-CityStateCode.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\ConvertFrom-ProductCode.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\ConvertTo-CityCode.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\ConvertTo-ProductCode.Tests.ps1" -Output Detailed

Invoke-Pester "$tests\Get-CountryCodes.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedAddressLine1.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedAddressLine2.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedBin.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedCity.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedCompany.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedDate.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedJobTitle.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\Get-FabricatedName.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedPhone.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedPostalCode.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedState.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedTaxpayerID.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\Get-FabricatedTime.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\Get-StateName.Tests.ps1" -Output Detailed

# Invoke-Pester "$tests\New-FabricatedCityStatePostalCodeRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedCompanyRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedCustomerRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedEmployeeRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedInventoryRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedNameRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedProductRecord.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedProductTable.Tests.ps1" -Output Detailed
# Invoke-Pester "$tests\New-FabricatedSalesRecord.Tests.ps1" -Output Detailed

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


