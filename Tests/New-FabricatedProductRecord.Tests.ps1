<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedProductRecord.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedProductRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedProductRecord.Tests'  # Remove .Tests from the name then remove this comment
    $here = $PSScriptRoot

    # Load data for validation
    $colors = Get-Content .\Data\Data-Colors.txt
    $clothing = Get-Content .\Data\Data-Clothing.txt
    $sizes = Get-Content .\Data\Data-Sizes.txt

    # Load data to test with
    $prod = New-FabricatedProductRecord

  }

  Context "<module> <function> Tests" {
    It "<function>.ProductCode is valid" {
      $code = $prod.Clothing.Substring(0,3).ToUpper() `
            + $prod.Color.Substring(0,3).ToUpper() `
            + $prod.Size.Substring(0,3).ToUpper()
      $prod.ProductCode | Should -Be $code
    }

    It "<function>.Clothing is valid" {
      $clothing | Should -Contain $prod.Clothing
    }

    It "<function>.Color is valid" {
      $colors | Should -Contain $prod.Color
    }

    It "<function>.Size is valid" {
      $sizes | Should -Contain $prod.Size
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests