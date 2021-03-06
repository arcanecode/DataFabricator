<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedProductTable.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedProductTable.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedProductTable'
    $here = $PSScriptRoot

    # Load data for validation
    $colors = Get-Content .\Data\Data-Colors.txt
    $clothing = Get-Content .\Data\Data-Clothing.txt
    $sizes = Get-Content .\Data\Data-Sizes.txt

    # Load data to test with
    $products = New-FabricatedProductTable
  }

  Context "<module> <function> Tests" {
    It "<function> returns rows" {
      $products.Count | Should -BeGreaterThan 0
    }

    It "<function>.ProductCode is valid" {
      $code = $products[0].Clothing.Substring(0,3).ToUpper() `
            + $products[0].Color.Substring(0,3).ToUpper() `
            + $products[0].Size.Substring(0,3).ToUpper()
      $products[0].ProductCode | Should -Be $code
    }

    It "<function>.Clothing is valid" {
      $clothing | Should -Contain $products[0].Clothing
    }

    It "<function>.Color is valid" {
      $colors | Should -Contain $products[0].Color
    }

    It "<function>.Size is valid" {
      $sizes | Should -Contain $products[0].Size
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests