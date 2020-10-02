<#-------------------------------------------------------------------------------------------------
  Data Fabricator - ConvertFrom-CityStateCode.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "ConvertFrom-CityStateCode Tests" {

  BeforeAll{
    $module = 'DataFabricator'
    $function = 'ConvertFrom-CityStateCode'
    $here = $PSScriptRoot
    $cityStateCodeUS = 'ALAARONSBURGCDP'
    $cityStateCodeUK = 'ALSTDAVIDS'
    $expectedCityUS = 'Aaronsburg CDP'
    $expectedCityUK = 'St Davids'
    $expectedStateUS = 'AL'
    $expectedStateUK = 'AL'
  } 

  Context "<module> <function> Tests" {
    It "<function> Default Country Code CityStateCode of <cityStateCodeUS> returns <expectedCityUS>, <expectedStateUS>" {
      $(ConvertFrom-CityStateCode -CityStateCode $cityStateCodeUS).State | Should -Be $expectedStateUS
      $(ConvertFrom-CityStateCode -CityStateCode $cityStateCodeUS).City  | Should -Be $expectedCityUS
    }

    It "<function> CountryCode of US CityStateCode of <cityStateCodeUS> returns <expectedCityUS>, <expectedStateUS>" {
      $(ConvertFrom-CityStateCode -CountryCode 'US' -CityStateCode $cityStateCodeUS).State | Should -Be $expectedStateUS
      $(ConvertFrom-CityStateCode -CountryCode 'US' -CityStateCode $cityStateCodeUS).City  | Should -Be $expectedCityUS
    }

    It "<function> CountryCode of UK CityStateCode of <cityStateCodeUK> returns <expectedCityUK>, <expectedStateUK>" {
      $(ConvertFrom-CityStateCode -CountryCode 'UK' -CityStateCode $cityStateCodeUK).State | Should -Be $expectedStateUK
      $(ConvertFrom-CityStateCode -CountryCode 'UK' -CityStateCode $cityStateCodeUK).City  | Should -Be $expectedCityUK
    }
  }

}