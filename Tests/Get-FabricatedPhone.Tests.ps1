<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedPhone.Tests.ps1
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

Describe "DataFabricator Get-FabricatedPhone.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedPhone'
    $here = $PSScriptRoot

  }

  Context "<module> <function> Tests" {
    It "<function> with default contry code matches a pattern of 111-111-1111" {
      Get-FabricatedPhone | Should -Match '\d{3}-\d{3}-\d{4}'
    }

    It "<function> -ContryCode US matches a pattern of 111-111-1111" {
      Get-FabricatedPhone | Should -Match '\d{3}-\d{3}-\d{4}'
    }

    It "<function> -NoFormatting matches a pattern of 1111111111" {
      Get-FabricatedPhone -NoFormatting | Should -Match '\d{10}'
    }

    It "<function> -PhonePrefix 555 with default contry code matches a pattern of 555-111-1111" {
      Get-FabricatedPhone -PhonePrefix 555 | Should -Match '555-\d{3}-\d{4}'
    }

    It "<function> -ContryCode US -PhonePrefix 555 matches a pattern of 555-111-1111" {
      Get-FabricatedPhone -PhonePrefix 555 | Should -Match '555-\d{3}-\d{4}'
    }

    It "<function> -NoFormatting matches a pattern of 1111111111" {
      Get-FabricatedPhone -NoFormatting | Should -Match '\d{10}'
    }

    It "<function> -NoFormatting -PhonePrefix 555 matches a pattern of 5551111111" {
      Get-FabricatedPhone -NoFormatting -PhonePrefix 555 | Should -Match '555\d{7}'
    }

    It "<function> -CountryCode UK matches a pattern of (111) 1111 1111" {
      Get-FabricatedPhone -CountryCode 'UK' | Should -Match '\(\d{3}\) \d{4} \d{4}'
    }

    It "<function> -CountryCode UK -NoFormatting matches a pattern of 11111111111" {
      Get-FabricatedPhone -CountryCode 'UK' -NoFormatting | Should -Match '\d{11}'
    }

    It "<function> -CountryCode UK -PhonePrefix 555 matches a pattern of (555) 1111 1111" {
      Get-FabricatedPhone -CountryCode 'UK' -PhonePrefix 555 | Should -Match '\(555\) \d{4} \d{4}'
    }

    It "<function> -CountryCode UK -NoFormatting -PhonePrefix 555 matches a pattern of 55511111111" {
      Get-FabricatedPhone -CountryCode 'UK' -NoFormatting -PhonePrefix 555 | Should -Match '555\d{8}'
    }
  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests