<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedSalesRecord.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedSalesRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedSalesRecord.Tests'  # Remove .Tests from the name then remove this comment
    $here = $PSScriptRoot

    # Load data for validation
    $colors = Get-Content .\Data\Data-Colors.txt
    $clothing = Get-Content .\Data\Data-Clothing.txt
    $sizes = Get-Content .\Data\Data-Sizes.txt

    $prodCodes = @()
    foreach($clothing in $clothing)
    {
      foreach($color in $colors)
      {
        foreach($size in $sizes)
        {
        $prodCodes += $clothing.Substring(0,3).ToUpper() `
                    + $color.Substring(0,3).ToUpper() `
                    + $size.Substring(0,3).ToUpper()
        }
      }
    }

    # Load data to test with
    $employees = New-FabricatedEmployeeRecord -RecordCount 10
    $products = New-FabricatedProductRecord -RecordCount 100
    $customers = New-FabricatedCustomerRecord -RecordCount 20

    $sale = New-FabricatedSalesRecord -Employees $employees `
                                      -Products $products `
                                      -Customers $customers 
  }

  Context "<module> <function> Tests" {
    It "<function>.EmployeeID should match a pattern of AA1234" {
      $sale.EmployeeID | Should -Match '[A-Z]{2}\d{4}'
    }

    It "<function>.CustomerID should match a pattern of AA1234" {
      $sale.CustomerID | Should -Match '[A-Z]{2}\d{4}'
    }

    It "<function>.ProductCode should be valid" {
      $prodCodes | Should -Contain $sale.ProductCode
    }

    It "<function>.Quantity returns value greater than 0" {
      $sale.Quantity | Should -BeGreaterThan 0
    }

    It "<function>.PricePerProduct returns value greater than 0" {
      $sale.PricePerProduct | Should -BeGreaterThan 0
    }

    It "<function>.TotalSale returns value greater than 0" {
      $sale.PricePerProduct | Should -BeGreaterThan 0
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests