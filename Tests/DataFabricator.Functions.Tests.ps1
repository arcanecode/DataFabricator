<#-------------------------------------------------------------------------------------------------
  Data Fabricator - DataFabricator.Functions.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script will test to make sure each function exists, is valid PowerShell, and has tests 
  for it. The $functions array has an entry for each function being tested.

  Note, we've chosen to not to write a test for Open-DataFabricatorWebsite. It is very simple,
  and it would be difficult to test to see if a persons default browser opened up a page,
  especially across multiple operating systems.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

  $functions = ( 'ConvertFrom-CityStateCode',
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
                 'Show-AboutDataFabricator',
                 'Show-DataFabricatorFunctions',
                 'Test-CountryCode'
               )

Describe "DataFabricator Function Tests" -ForEach $functions {

  BeforeAll{
    $function = $_
    $module = 'DataFabricator'
    $here = $PSScriptRoot

  }

  Context '<module> validating the files for function <function>' {

      It "<function>.ps1 should exist?" {
        "$here\..\Code\$function.ps1" | Should -Exist
      }

      It "<function> should have a SYNOPSIS section in the help block" {
        "$here\..\Code\$function.ps1" | Should -FileContentMatch '.SYNOPSIS'
      }

      It "<function> should have a DESCRIPTION section in the help block" {
        "$here\..\Code\$function.ps1" | Should -FileContentMatch '.DESCRIPTION'
      }

      It "<function> should have a EXAMPLE section in the help block" {
        "$here\..\Code\$function.ps1" | Should -FileContentMatch '.EXAMPLE'
      }

      It "<function> should be an advanced function" {
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'function'
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'cmdletbinding'
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'param'
      }

      It "<function> should contain at least one Write-Verbose block" {
        "$here\..\Code\$function.ps1" | Should -FileContentMatch 'Write-Verbose'
      }

      It "<function> is valid PowerShell code" {
        $psFile = Get-Content -Path "$here\..\Code\$function.ps1" `
                              -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should -Be 0
      }

  } # Context 'Files for each Function Exist'

  Context "<function> has a test" {
    It "<function>.Tests.ps1 should exist" {
        "$here\$function.Tests.ps1" | Should -Exist
    }
  }

}



