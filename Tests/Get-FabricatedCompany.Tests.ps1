<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedCompany.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.

  In this test, it's not important what is returned, as it's a random value. It is just
  important that something is returned.

  Second, we use a neat trick. By using $($function) PowerShell will resulve the name of our
  function being tested from the variable, then execute that. So all you really have to do
  is update the value of the $function variable in the BeforeAll block, and you don't
  have to touch the rest of the test
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator Get-FabricatedCompany.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedCompany'

  }

  Context "<module> <function> Tests" {
    It "<function> should return a value" {
      $($function).Length | Should -BeGreaterThan 0
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests