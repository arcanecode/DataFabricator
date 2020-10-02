<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedTaxpayerID.Tests.ps1
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

Describe "DataFabricator Get-FabricatedTaxpayerID.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedTaxpayerID'

  }

  Context "<module> <function> Tests" {
    It "<function> default country code matches a pattern of 111-22-3333" {
      Get-FabricatedTaxpayerID | Should -Match '\d{3}-\d{2}-\d{4}'
    }

    It "<function> -CountryCode 'US' matches a pattern of 111-22-3333" {
      Get-FabricatedTaxpayerID -CountryCode 'US' | Should -Match '\d{3}-\d{2}-\d{4}'
    }

    It "<function> -NoFormatting with default country code matches a pattern of 111223333" {
      Get-FabricatedTaxpayerID -NoFormatting | Should -Match '\d{9}'
    }

    It "<function> -CountryCode 'US' -NoFormatting matches a pattern of 111223333" {
      Get-FabricatedTaxpayerID -CountryCode 'US' -NoFormatting | Should -Match '\d{9}'
    }

    It "<function> -CountryCode 'UK' matches a pattern of 01234 56789" {
      Get-FabricatedTaxpayerID -CountryCode 'UK' | Should -Match '\d{5} \d{5}'
    }

    It "<function> -CountryCode 'UK' -NoFormatting matches a pattern of 0123456789" {
      Get-FabricatedTaxpayerID -CountryCode 'UK' -NoFormatting | Should -Match '\d{10}'
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests