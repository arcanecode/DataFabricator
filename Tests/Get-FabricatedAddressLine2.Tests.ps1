<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedAddressLine2.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.

  In this test, it's not important what is returned, as it's a random value. It is just
  important that something is returned.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator Get-FabricatedAddressLine2.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedAddressLine2'

  }

  Context "<module> <function> Tests" {
    It "<function> should return a value when Threshold is 100" {
      # Because this function only returns a test some of the time, we will have to use the
      # threshold parameter to make it return a value on every execution. Because we have to
      # use a parameter, we'll have to explictly use the function name
      $(Get-FabricatedAddressLine2 -Threshold 100).Length | Should -BeGreaterThan 0
    }

    It "<function> should not return a value Threshold is 0" {
      # Now we'll ensure it does NOT return a value when threshold is 0
      $(Get-FabricatedAddressLine2 -Threshold 0).Length | Should -BeExactly 0
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests