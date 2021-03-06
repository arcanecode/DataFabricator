<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-CountryCodes.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# The data that should be returned
$countryCodes = @( 'Unspecified',
                   'US',
                   'UK'
                 )

# Test scenarios must be declared outside of the Describe block
$scenarios = @()

# Build an array of hashes with the data we are checking for
foreach ($item in $countryCodes)
  { $scenarios += @{ inputValue = $item } }

Describe "DataFabricator Get-CountryCodes Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-CountryCodes'
    $here = $PSScriptRoot

  }

  Context "<module> <function> Tests" {
    It "<function> returns a collection of 3 items" {
      $(Get-CountryCodes).Count | Should -BeExactly 3
    }
  } # Context "<module> <function> Tests"

  Context "<module> <function> test for each item present in output" {
    It "<function> <inputValue> should be in the output" -TestCases $scenarios {
      Get-CountryCodes | Should -Contain $inputValue
    }

  } # Context "<module> <function> test for each item present in output" 

} # Describe DataFabricator Tests