<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedName.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator Get-FabricatedName.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedName'
    $here = $PSScriptRoot
    $namesFirst = Get-Content .\Data\Data-NamesFirst.txt
    $namesLast = Get-Content .\Data\Data-NamesLast.txt

  }

  Context "<module> <function> Tests" {
    It "<function> -First returns a valid first name" {
      $namesFirst | Should -Contain  $(Get-FabricatedName -First)
    }

    It "<function> -Last returns a valid last name" {
      $namesLast | Should -Contain  $(Get-FabricatedName -Last)
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests