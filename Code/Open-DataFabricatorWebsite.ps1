<#
.SYNOPSIS
Opens the GitHub site for DataFabricator in your default browser.

.DESCRIPTION
As stated, this will open my github site for the DataFabricator project. This should make it easy to quickly open the site.

You can also pass in the name of a function, and it will jump directly to that function. Because this assembles a URL out of the function name, the case of the function name must match exactly, i.e. Get-FabricatedBin and not get-fabricatedbin.

Note that Microsoft Edge doesn't always pop up above your current terminal or VSCode, so look for it flashing in the Windows toolbar if Edge is your default browser.

Also, don't trust me by default. Check out the source code before you use this so, from a security perspective, you'll be sure you are getting sent to github. While I wouldn't do anything nefarious, you should always be cautions when opening up strange webistes.

.PARAMETER FunctionName
The name of one of the many functions within the DataFabricator module. To see a short list of all the commands, use Get-Command -Module DataFabricator | Select-Object Name

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Opens the DataFabricator site on GitHub.

.EXAMPLE
Open-DataFabricatorWebsite

Opens the github page for DataFabricator in your default web browser.

.EXAMPLE
Open-DataFabricatorWebsite -FunctionName Get-FabricatedBin

Opens the github page for DataFabricator in your default web browser and jumps directly to the Get-FabricatorBin documentation page.

.NOTES
Data Fabricator - Open-DataFabricatorWebsite.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Open-DataFabricatorWebsite()
{
  [CmdletBinding()]
  param (
          [string] $FunctionName = 'missing'
        )

  $functions = @( 'ConvertFrom-CityStateCode',
                  'ConvertFrom-ProductCode',
                  'ConvertTo-CityCode',
                  'ConvertTo-ProductCode',
                  'Get-CountryCodes',
                  'Get-FabricatedAddressLine1',
                  'Get-FabricatedAddressLine2',
                  'Get-FabricatedBin',
                  'Get-FabricatedCity',
                  'Get-FabricatedCompany',
                  'Get-FabricatedDate',
                  'Get-FabricatedJobTitle',
                  'Get-FabricatedName',
                  'Get-FabricatedPhone',
                  'Get-FabricatedPostalCode',
                  'Get-FabricatedState',
                  'Get-FabricatedTaxpayerID',
                  'Get-FabricatedTime',
                  'Get-StateName',
                  'New-FabricatedCityStatePostalCodeRecord',
                  'New-FabricatedCompanyRecord',
                  'New-FabricatedCustomerRecord',
                  'New-FabricatedEmployeeRecord',
                  'New-FabricatedInventoryRecord',
                  'New-FabricatedNameRecord',
                  'New-FabricatedProductRecord',
                  'New-FabricatedProductTable',
                  'New-FabricatedSalesRecord',
                  'Open-DataFabricatorWebsite',
                  'Show-AboutDataFabricator',
                  'Show-DataFabricatorFunctions',
                  'Test-CountryCode'
               )

  if ($FunctionName -eq 'missing' )
    { $url = 'https://github.com/arcanecode/DataFabricator' }
  else
  {
    # $commands = Get-Command -Module DataFabricator | Select-Object Name
    if ($functions -contains $FunctionName)
    { $url = "https://github.com/arcanecode/DataFabricator/blob/master/Documentation/$FunctionName.md" }
    else
    { $url = 'https://github.com/arcanecode/DataFabricator' }
  }

  Start-Process $url

}
