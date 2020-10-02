<#-------------------------------------------------------------------------------------------------
  Data Fabricator - ConvertFrom-ProductCode.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator ConvertFrom-ProductCode Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'ConvertFrom-ProductCode'
    $here = $PSScriptRoot
    $productCode = 'GLOOCELAR'
    $expectedColor = 'Ocean Green'
    $expectedClothing = 'Gloves'
    $expectedSize = 'Large'
    $colors = Get-Content "$here\..\Data\Data-Colors.txt"
    $clothing = Get-Content "$here\..\Data\Data-Clothing.txt"
    $sizes = Get-Content "$here\..\Data\Data-Sizes.txt"
  }

  Context "<module> <function> Tests" {

    # First validate these values are in the product table files
    It "<function> returns a valid color for product code <productCode>" {
      $(ConvertFrom-ProductCode -ProductCode $productCode).Color | Should -BeIn $colors
    }

    It "<function> returns a valid clothing for product code <productCode>" {
      $(ConvertFrom-ProductCode -ProductCode $productCode).Clothing | Should -BeIn $clothing
    }

    It "<function> returns a valid size for product code <productCode>" {
      $(ConvertFrom-ProductCode -ProductCode $productCode).Size | Should -BeIn $sizes
    }

    # Now validate they return the values based on the data passed in
    It "<function> returns a color of <expectedColor> for product code <productCode>" {
      $(ConvertFrom-ProductCode -ProductCode $productCode).Color | Should -Be $expectedColor
    }

    It "<function> returns clothing type of <expectedClothing> for product code <productCode>" {
      $(ConvertFrom-ProductCode -ProductCode $productCode).Clothing | Should -Be $expectedClothing
    }

    It "<function> returns a size of <expectedSize> for product code <productCode>" {
      $(ConvertFrom-ProductCode -ProductCode $productCode).Size | Should -Be $expectedSize
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests