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
Install-Module Pester -RequiredVersion "5.1.0-beta4" -AllowPrerelease -Force

# Once the 5.1.0 version of Pester is released, you can uncomment the following line
# and use it instead, deleting the previous line.
# Install-Module Pester -RequiredVersion "5.1.0" -Force

# Import it, then confirm it's in memory
Import-Module Pester -RequiredVersion "5.1.0"
Get-Module Pester -ListAvailable

# Before running, you need to have the most current version loaded in memory.
# Typically this is done in each test, but it takes a minute or two to load
# the module so I'm doing it here once, rather than in each test, in order
# to make test execution run faster. It's up to you to manually unload
# whatever version is in memory and reload, so you get the most current version.
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module "$pwd/DataFabricator"

# Note, I've chosen to skip tests for the Show-* cmdlets, as all they do is
# display a string of text. Likewise, I've omitted the Open-* cmdlet, as it
# just opens a webpage.

# You can run all of the tests using Invoke-Pester, and passing
# in the directory with the tests. Note running all tests take just
# under three minutes.
Invoke-Pester Tests

# Just in case someone hits F5 by accident, I didn't want it to run all the tests
# multiple times. So I'm adding the line of code below to exist the script
# just in case.
if ( 1 -eq 1 ) { exit }


# If you want to see the detail on each test, pass in -Output Detailed
Invoke-Pester Tests -Output Detailed

# Or you can run tests one at a time using the commands below

# First, set a variable to get the current folder
$tests = "$pwd\Tests"

# Now you can pick the test to run
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
Invoke-Pester "$tests\Get-FabricatedName.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedPhone.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedPostalCode.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedState.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedTaxpayerID.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-FabricatedTime.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Get-StateName.Tests.ps1" -Output Detailed

Invoke-Pester "$tests\New-FabricatedCityStatePostalCodeRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedCompanyRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedCustomerRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedEmployeeRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedInventoryRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedNameRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedProductRecord.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedProductTable.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\New-FabricatedSalesRecord.Tests.ps1" -Output Detailed

Invoke-Pester "$tests\Show-AboutDataFabricator.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Show-DataFabricatorFunctions.Tests.ps1" -Output Detailed
Invoke-Pester "$tests\Test-CountryCode.Tests.ps1" -Output Detailed



