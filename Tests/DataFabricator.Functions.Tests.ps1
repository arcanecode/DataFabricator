#------------------------------------------------------------------------------------------------
# In version 5.1 of Pester, the author has indicated they want to enable
# looping for a Describe block in the manner below.
# In version 5.0.x, however, this is not implemented so having to do
# loops in the IT blocks as shown in the DataFabricator.Module.Tests.ps1
# I've left this sa an example, so when Pester 5.1 is released
# I can test it and hopefully shift testing over to this model
#------------------------------------------------------------------------------------------------

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



