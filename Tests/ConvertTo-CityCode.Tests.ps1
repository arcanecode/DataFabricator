<#-------------------------------------------------------------------------------------------------
  Data Fabricator - ConvertTo-CityCode.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator ConvertTo-CityCode Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'ConvertTo-CityCode'
    $here = $PSScriptRoot
    $testValue = "Aa -,'bB123cc"
    $expectedValue = 'AABB123CC'

  }

  Context "<module> <function> Tests" {
    It "<function> passes in a value of <testValue> and returns <expectedValue>" {
      $(ConvertTo-CityCode -City $testValue) | Should -Be $expectedValue
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests