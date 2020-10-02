<#-------------------------------------------------------------------------------------------------
  Data Fabricator - ConvertTo-ProductCode.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator ConvertTo-ProductCode Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'ConvertTo-ProductCode'
    $here = $PSScriptRoot
    $testClothing = 'Aaaaaaaa'
    $testColor = 'Bbbbbbb'
    $testSize = 'Cccccc'
    $expectedResult = 'AAABBBCCC'
  }

  Context "<module> <function> Tests" {
    It "<function> returns value of <expectedResult>" {
      $(ConvertTo-ProductCode -Clothing $testClothing `
                              -Color $testColor `
                              -Size $testSize) |
      Should -Be $expectedResult
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests