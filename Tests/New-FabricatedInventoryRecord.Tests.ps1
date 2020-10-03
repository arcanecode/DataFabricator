<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedInventoryRecord.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.

  ---------------------------------------------------------------------------------------------

  Common RegEx Syntax
    [A-Z]  - Single uppercase letter in the range A to Z
    [ABCD] - Single uppercase letter from the letters in A, B, C, or D
    \d     - Single digit
    \D     - Single character that is not a digit
    {3}    - Quantifer after another syntax, for example \d{3} is three numbers.
             [A-Z]{2,4} reprents 2 to 4 uppercase letters
             [A-Z]{2,} represents 2 or more uppercase letters
    \s     -  Whitespace character, such as spaces, tabs, line returns, [A-Z]\s[A-Z]
    +      - One or more of a value, [A-Z]+
    ?      - Once or none, A?C matches ABC, ADC, etc.
    .      - Any character except line break, a.c matches abc, acc, adc, etc.

  Special Characters
    \t     - Tab character
    \r     - Carriage return character
    \n     - Line feed character
    \r\n   - Line feed character

  Characters that need to be escaped with a single backslash \ before using them as a literal
    . * + ? $ ^ / \ [ ] { } ( )

  For a more extensive guide to RegEx, please see:
    https://www.rexegg.com/regex-quickstart.html
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedInventoryRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedInventoryRecord.Tests'  # Remove .Tests from the name then remove this comment
    $here = $PSScriptRoot

    $colors = Get-Content .\Data\Data-Colors.txt
    $clothing = Get-Content .\Data\Data-Clothing.txt
    $sizes = Get-Content .\Data\Data-Sizes.txt

    # Load US Data
    $citiesUS = Get-Content .\Data\Data-CitiesUS.txt
    $stateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt
    $stateNameUS = Get-Content .\Data\Data-StateNameUS.txt

    $cityCodesUS = @()
    foreach($city in $citiesUS)
    {
      $cityCodesUS += $city.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()
    }

    # Load UK Data
    $citiesUK = Get-Content .\Data\Data-CitiesUK.txt
    $stateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt
    $stateNameUK = Get-Content .\Data\Data-StateNameUK.txt

    $cityCodesUK = @()
    foreach($city in $citiesUK)
    {
      $cityCodesUK += $city.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()
    }

    # Load a list of product codes
    $prodCodes = @()
    foreach($clothing in $clothing)
    {
      foreach($color in $colors)
      {
        foreach($size in $sizes)
        {
        $prodCodes += $clothing.Substring(0,3).ToUpper() `
                    + $color.Substring(0,3).ToUpper() `
                    + $size.Substring(0,3).ToUpper()
        }
      }
    }

    $inv = New-FabricatedInventoryRecord

  }

  Context "<module> <function> Tests" {
    It "<function>.ProductCode is valid" {
      $prodCodes | Should -Contain $inv.ProductCode
    }

    It "<function>.WarehouseCode is valid" {
      $st = $inv.WarehouseCode.Substring(0, 2)
      $city = $inv.WarehouseCode.Substring(2)
      $stateAbbrUS | Should -Contain $st
      $cityCodesUS | Should -Contain $city
    }

    It "<function>.Bin is valid" {
      $inv.Bin | Should -Match '[A-Z]{2}\d{3}'
    }

    It "<function>.WarehouseBinCode is valid" {
      $st = $inv.WarehouseBinCode.Substring(0, 2)
      $city = $inv.WarehouseBinCode.Substring(2, $inv.WarehouseBinCode.Length -7)
      $bin = $inv.WarehouseBinCode.Substring($inv.WarehouseBinCode.Length -5)
      $stateAbbrUS | Should -Contain $st
      $cityCodesUS | Should -Contain $city
      $bin | Should -Match '[A-Z]{2}\d{3}'
    }

    It "<function>.Quantity is valid" {
      $inv.Quantity | Should -BeGreaterThan 0
    }   

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests