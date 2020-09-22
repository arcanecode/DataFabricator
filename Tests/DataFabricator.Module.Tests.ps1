Describe -Tags ('Unit', 'Acceptance') "DataFabricator Module Tests"  {

  BeforeAll {
    $module = 'DataFabricator'
    $here = Split-Path -parent $PSCommandPath

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

  } # BeforeAll

  Context 'Module Setup' {

    It "$module has the root module $module.psm1" {
      "$here\..\$module.psm1" | Should -Exist
    }

    It "has the a manifest file of $module.psd1" {
      "$here\..\$module.psd1" | Should -Exist
      "$here\..\$module.psd1" | Should -FileContentMatch "$module.psm1"
    }

    It "$module folder has Get functions" {
      "$here\..\Code\Get-*.ps1" | Should -Exist
    }

    It "$module folder has New functions" {
      "$here\..\Code\New-*.ps1" | Should -Exist
    }

    It "$module folder has Test functions" {
      "$here\..\Code\New-*.ps1" | Should -Exist
    }

    It "$module is valid PowerShell code" {
      $psFile = Get-Content -Path "$here\..\$module.psm1" `
                            -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
      $errors.Count | Should -Be 0
    }

  } # Context 'Module Setup'

  Context 'Files for each Function Exist' {


      It "Do files for each function exist?" {
        foreach ($function in $functions)
        {
          "$here\..\Code\$function.ps1" | Should -Exist
        }
      }

      It "Each function should have a SYNOPSIS section in the help block" {
        foreach ($function in $functions)
        {
          "$here\..\Code\$function.ps1" | Should -FileContentMatch '.SYNOPSIS'
        }
      }

      It "Each function should have a DESCRIPTION section in the help block" {
        foreach ($function in $functions)
        {
          "$here\..\Code\$function.ps1" | Should -FileContentMatch '.DESCRIPTION'
        }
      }

      It "Each function should have a EXAMPLE section in the help block" {
        foreach ($function in $functions)
        {
          "$here\..\Code\$function.ps1" | Should -FileContentMatch '.EXAMPLE'
        }
      }

      It "Each function should be an advanced function" {
        foreach ($function in $functions)
        {
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'function'
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'cmdletbinding'
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'param'
        }
      }

      It "Each function should contain at least one Write-Verbose block" {
        foreach ($function in $functions)
        {
          "$here\..\Code\$function.ps1" | Should -FileContentMatch 'Write-Verbose'
        }
      }

      It "Each function is valid PowerShell code" {
        foreach ($function in $functions)
        {
          $psFile = Get-Content -Path "$here\..\Code\$function.ps1" `
                                -ErrorAction Stop
          $errors = $null
          $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
          $errors.Count | Should -Be 0
        }
      }

  } # Context 'Files for each Function Exist'

  Context "Checking to see if all functions have a test" {
    It "Tests for each function should exist" {
      foreach ($function in $functions)
      {
        "$here\$function.Tests.ps1" | Should -Exist
      }
    }
  }


}