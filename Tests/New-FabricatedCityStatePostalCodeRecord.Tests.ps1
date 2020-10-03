<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedCityStatePostalCodeRecord.Tests.ps1
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

  ---------------------------------------------------------------------------------------------

  Notes
    The CityCode property is calculated by ConvertTo-CityCode, and thus is covered by
    its test.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedCityStatePostalCodeRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedCityStatePostalCodeRecord'
    $here = $PSScriptRoot

    # RegEx Match Strings
    $matchPostalCodeUS = '\d{5}'                        # Matches 12345
    $matchPostalCodePlus4US = '\d{5}-\d{4}'             # Matches 12345-6789
    $matchPhoneUS = '\d{3}-\d{3}-\d{4}'                 # Matches 555-55-5555
    $matchTaxpayerIdUS = '\d{3}-\d{2}-\d{4}'            # Matches 111-22-3333

    $matchPostalCodeUK = '[A-Z]{2}\d[A-Z] \d[A-Z]{2}'   # Matches AA0A 1AA
    $matchPhoneUK = '\(\d{3}\) \d{4} \d{4}'             # Matches (111) 2222 3333
    $matchTaxpayerIdMatch = '\d{5} \d{5}'               # Matches 12345 67890

    $matchDateYYYYMMDD = '\d{4}-\d{2}-\d{2}'            # Matches 2020-01-01
    $matchTimeHHMMSS = '\d{2}:\d{2}:\d{2}'              # Matches 23:59:59
    $matchTimeHHMMSSAMPM = '\d{2}:\d{2}:\d{2} [AP]M'    # Matches 12:59:59 PM

    # Load US Data
    $citiesUS = Get-Content .\Data\Data-CitiesUS.txt
    $stateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt
    $stateNameUS = Get-Content .\Data\Data-StateNameUS.txt

    # Load UK Data
    $citiesUK = Get-Content .\Data\Data-CitiesUK.txt
    $stateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt
    $stateNameUK = Get-Content .\Data\Data-StateNameUK.txt

    $csz = New-FabricatedCityStatePostalCodeRecord

    $cszUS = New-FabricatedCityStatePostalCodeRecord -CountryCode US

    $cszP4 = New-FabricatedCityStatePostalCodeRecord -Plus4

    $cszUK = New-FabricatedCityStatePostalCodeRecord -CountryCode UK

    $csz5Rows = New-FabricatedCityStatePostalCodeRecord -RecordCount 5

  }

  #----------------------------------------------------------------------------------------------
  #  Test to ensure we get the right number of records back/
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -RecordCount 5 Tests" {
    It "<function> -RecordCount 5 should have 5 rows" {
      $($csz5Rows).Count | Should -Be 5
    }    
  }

  #----------------------------------------------------------------------------------------------
  #  Tests for default CountryCode
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> default CountryCode Tests" {
    It "<function>.City should have a valid city" {
      $citiesUS | Should -Contain $csz.City
    }

    It "<function>.State should have a valid state" {
      $stateAbbrUS | Should -Contain $csz.State
    }

    It "<function>.StateName should have a valid state name" {
      $stateNameUS | Should -Contain $csz.StateName
    }

    It "<function>.PostalCode should have a valid postal code" {
      $csz.PostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.CityStPostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $csz.CityStPostalCode.Split(", ")
      $citiesUS | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      $stateAbbrUS | Should -Contain $sp[0]
      $sp[1] | Should -Match $matchPostalCodeUS
    }

    It "<function>.CityStatePostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $csz.CityStatePostalCode.Split(", ")
      $citiesUS | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      # Some states have two parts to the name, like New York. If so, the $sp will have 3 
      # elements (New, York, then the code). Others will only have two, (Alabama, postal code)
      # Adjust the test based on the number of elements in the array
      if ($sp.Count -eq 3) {
        $stateNameUS | Should -Contain "$($sp[0]) $($sp[1])"
        $sp[2] | Should -Match $matchPostalCodeUS
      }
      else  #only two elements
      {
        $stateNameUS | Should -Contain $sp[0]
        $sp[1] | Should -Match $matchPostalCodeUS
      }
    }

  } # Context "<module> <function> default CountryCode Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for CountryCode US
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -CountryCode US Tests" {
    It "<function>.City should have a valid city" {
      $citiesUS | Should -Contain $cszUS.City
    }

    It "<function>.State should have a valid state" {
      $stateAbbrUS | Should -Contain $cszUS.State
    }

    It "<function>.StateName should have a valid state name" {
      $stateNameUS | Should -Contain $cszUS.StateName
    }

    It "<function>.PostalCode should have a valid postal code" {
      $cszUS.PostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.CityStPostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $cszUS.CityStPostalCode.Split(", ")
      $citiesUS | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      $stateAbbrUS | Should -Contain $sp[0]
      $sp[1] | Should -Match $matchPostalCodeUS
    }

    It "<function>.CityStatePostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $cszUS.CityStatePostalCode.Split(", ")
      $citiesUS | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      # Some states have two parts to the name, like New York. If so, the $sp will have 3 
      # elements (New, York, then the code). Others will only have two, (Alabama, postal code)
      # Adjust the test based on the number of elements in the array
      if ($sp.Count -eq 3) {
        $stateNameUS | Should -Contain "$($sp[0]) $($sp[1])"
        $sp[2] | Should -Match $matchPostalCodeUS
      }
      else  #only two elements
      {
        $stateNameUS | Should -Contain $sp[0]
        $sp[1] | Should -Match $matchPostalCodeUS
      }
    }

  } # Context "<module> <function> -CountryCode US Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for Default CountryCode with Plus4 Switch
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -Plus4 Tests" {
    It "<function>.City should have a valid city" {
      $citiesUS | Should -Contain $cszP4.City
    }

    It "<function>.State should have a valid state" {
      $stateAbbrUS | Should -Contain $cszP4.State
    }

    It "<function>.StateName should have a valid state name" {
      $stateNameUS | Should -Contain $cszP4.StateName
    }

    It "<function>.PostalCode should have a valid postal code" {
      $cszP4.PostalCode | Should -Match $matchPostalCodePlus4US
    }

    It "<function>.CityStPostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $cszP4.CityStPostalCode.Split(", ")
      $citiesUS | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      $stateAbbrUS | Should -Contain $sp[0]
      $sp[1] | Should -Match $matchPostalCodePlus4US
    }

    It "<function>.CityStatePostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $cszP4.CityStatePostalCode.Split(", ")
      $citiesUS | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      # Some states have two parts to the name, like New York. If so, the $sp will have 3 
      # elements (New, York, then the code). Others will only have two, (Alabama, postal code)
      # Adjust the test based on the number of elements in the array
      if ($sp.Count -eq 3) {
        $stateNameUS | Should -Contain "$($sp[0]) $($sp[1])"
        $sp[2] | Should -Match $matchPostalCodeUS
      }
      else  #only two elements
      {
        $stateNameUS | Should -Contain $sp[0]
        $sp[1] | Should -Match $matchPostalCodeUS
      }
    }

  } # Context "<module> <function> -Plus4 Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for CountryCode UK
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -CountryCode UK Tests" {
    It "<function>.City should have a valid city" {
      $citiesUK | Should -Contain $cszUK.City
    }

    It "<function>.State should have a valid state" {
      $stateAbbrUK | Should -Contain $cszUK.State
    }

    It "<function>.StateName should have a valid state name" {
      $stateNameUK | Should -Contain $cszUK.StateName
    }

    It "<function>.PostalCode should have a valid postal code" {
      $cszUK.PostalCode | Should -Match $matchPostalCodeUK
    }

    It "<function>.CityStPostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $cszUK.CityStPostalCode.Split(", ")
      $citiesUK | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      $stateAbbrUK | Should -Contain $sp[0]
      # UK postal codes have a space so we need to add 'em back together
      "$($sp[1]) $($sp[2])" | Should -Match  $matchPostalCodeUK
    }

    It "<function>.CityStatePostalCode should be valid" {
      # First, split on the , to get city apart from state/postal code
      $csp = $cszUK.CityStatePostalCode.Split(", ")
      $citiesUK | Should -Contain $csp[0]
      # Now split the state and postal code
      $sp = $csp[1].Split(" ")
      # Some states have two parts to the name, like New York. If so, the $sp will have 4 
      # elements (County, Durham, then the two part code). Others will only have three,
      # (Cornwall, the the two part postal code)
      # Adjust the test based on the number of elements in the array
      if ($sp.Count -eq 4) {
        $stateNameUS | Should -Contain "$($sp[0]) $($sp[1])"
        "$($sp[2]) $($sp[3])" | Should -Match  $matchPostalCodeUK
      }
      else  #only three elements
      {
        $stateNameUK | Should -Contain $sp[0]
        # UK postal codes have a space so we need to add 'em back together
        "$($sp[1]) $($sp[2])" | Should -Match  $matchPostalCodeUK
      }

    }

  } # Context "<module> <function> -CountryCode UK Tests"

} # Describe DataFabricator Testsr