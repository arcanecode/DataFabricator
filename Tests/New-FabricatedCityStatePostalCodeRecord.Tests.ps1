<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedCityStatePostalCodeRecord.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedCityStatePostalCodeRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedCityStatePostalCodeRecord'
    $here = $PSScriptRoot

  }

  Context "<module> <function> Tests" {
    It "<function> returns value of x" {
      $(function here) | Should -Be 'xyz'
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests