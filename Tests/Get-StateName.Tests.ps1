<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-StateName.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator Get-StateName.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-StateName'
    $usInput = 'AL'
    $usOutput = 'Alabama'
    $ukInput = 'CA'
    $ukOutput = 'Cambridgeshire'
  }

  Context "<module> <function> Tests" {
    It "<function> -StateAbbr '<usInput>' returns <usOutput> (default country code)" {
      Get-StateName -StateAbbr $usInput | Should -Be $usOutput
    }

    It "<function> -StateAbbr '<usInput>' -CountryCode 'US' returns <usOutput>" {
      Get-StateName -StateAbbr $usInput | Should -Be $usOutput
    }

    It "<function> -StateAbbr '<ukInput>' -CountryCode 'UK' returns <ukOutput>" {
      Get-StateName -StateAbbr $ukInput -CountryCode 'UK' | Should -Be $ukOutput
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests