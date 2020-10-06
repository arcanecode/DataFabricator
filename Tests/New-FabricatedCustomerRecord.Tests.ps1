<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedCustomerRecord.Tests.ps1
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

Describe "DataFabricator New-FabricatedCustomerRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedCustomerRecord'
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

    # Load Names
    $namesFirst = Get-Content .\Data\Data-NamesFirst.txt
    $namesLast = Get-Content .\Data\Data-NamesLast.txt

    # Load address 2
    $address2First = Get-Content .\Data\Data-Address2.txt

    # Load US Data
    $citiesUS = Get-Content .\Data\Data-CitiesUS.txt
    $stateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt

    # Load UK Data
    $citiesUK = Get-Content .\Data\Data-CitiesUK.txt
    $stateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt

    $coDF = New-FabricatedCustomerRecord
    $coUS = New-FabricatedCustomerRecord -CountryCode 'US'
    $coUK = New-FabricatedCustomerRecord -CountryCode 'UK'

  }

  #----------------------------------------------------------------------------------------------
  #  Tests for default country code
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> default country code Tests" {
    It "<function>.FirstName is valid" {
      $namesFirst | Should -Contain $coDF.FirstName
    }

    It "<function>.MiddleName is valid" {
      $namesFirst | Should -Contain $coDF.MiddleName
    }

    It "<function>.LastName is valid" {
      $namesLast | Should -Contain $coDF.LastName
    }

    It "<function>.FullName is valid" {
      $fullName = $coDF.FullName.Split(' ')
      $namesFirst | Should -Contain $fullName[0]
      $namesFirst | Should -Contain $fullName[1]
      $namesLast | Should -Contain $fullName[2]
    }

    It "<function>.CustomerID is valid" {
      $coDF.CustomerID | Should -Match '[A-Z]{2}\d{6}'
    }

    It "<function>.Email is valid" {
      $email = $coDF.Email.Split('@')
      $email[0] | Should -Be "$($($coDF.FirstName).Substring(0, 1).ToLower()).$($($coDF.LastName).ToLower())"
      $email[1] | Should -Be "fakemail.com"
    }

    It "<function>.HomePhone is valid" {
      $coDF.HomePhone | Should -Match $matchPhoneUS
    }

    It "<function>.MobilePhone is valid" {
      $coDF.MobilePhone | Should -Match $matchPhoneUS
    }

    It "<function>.WorkPhone is valid" {
      $coDF.WorkPhone | Should -Match $matchPhoneUS
    }

    It "<function>.HomeAddress1 is valid" {
      $coDF.HomeAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.HomeAddress2 is valid" {
      if ($coDF.HomeAddress2.Length -gt 0)
      {
        $addr2 = $coDF.HomeAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.HomeCity is valid" {
      $citiesUS | Should -Contain $coDF.HomeCity
    }

    It "<function>.HomeState is valid" {
      $stateAbbrUS | Should -Contain $coDF.HomeState
    }

    It "<function>.HomePostalCode is valid" {
      $coDF.HomePostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.WorkAddress1 is valid" {
      $coDF.WorkAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.WorkAddress2 is valid" {
      if ($coDF.WorkAddress2.Length -gt 0)
      {
        $addr2 = $coDF.WorkAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.WorkCity is valid" {
      $citiesUS | Should -Contain $coDF.WorkCity
    }

    It "<function>.WorkState is valid" {
      $stateAbbrUS | Should -Contain $coDF.WorkState
    }

    It "<function>.WorkPostalCode is valid" {
      $coDF.WorkPostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.BirthDate is valid" {
      $coDF.BirthDate | Should -Match '\d{4}-\d{2}-\d{2}'
    }

  } # Context "<module> <function> Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for CountryCode US
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> default country code Tests" {
    It "<function>.FirstName is valid" {
      $namesFirst | Should -Contain $coUS.FirstName
    }

    It "<function>.MiddleName is valid" {
      $namesFirst | Should -Contain $coUS.MiddleName
    }

    It "<function>.LastName is valid" {
      $namesLast | Should -Contain $coUS.LastName
    }

    It "<function>.FullName is valid" {
      $fullName = $coUS.FullName.Split(' ')
      $namesFirst | Should -Contain $fullName[0]
      $namesFirst | Should -Contain $fullName[1]
      $namesLast | Should -Contain $fullName[2]
    }

    It "<function>.CustomerID is valid" {
      $coUS.CustomerID | Should -Match '[A-Z]{2}\d{6}'
    }

    It "<function>.Email is valid" {
      $email = $coUS.Email.Split('@')
      $email[0] | Should -Be "$($($coUS.FirstName).Substring(0, 1).ToLower()).$($($coUS.LastName).ToLower())"
      $email[1] | Should -Be "fakemail.com"
    }

    It "<function>.HomePhone is valid" {
      $coUS.HomePhone | Should -Match $matchPhoneUS
    }

    It "<function>.MobilePhone is valid" {
      $coUS.MobilePhone | Should -Match $matchPhoneUS
    }

    It "<function>.WorkPhone is valid" {
      $coUS.WorkPhone | Should -Match $matchPhoneUS
    }

    It "<function>.HomeAddress1 is valid" {
      $coUS.HomeAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.HomeAddress2 is valid" {
      if ($coUS.HomeAddress2.Length -gt 0)
      {
        $addr2 = $coUS.HomeAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.HomeCity is valid" {
      $citiesUS | Should -Contain $coUS.HomeCity
    }

    It "<function>.HomeState is valid" {
      $stateAbbrUS | Should -Contain $coUS.HomeState
    }

    It "<function>.HomePostalCode is valid" {
      $coUS.HomePostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.WorkAddress1 is valid" {
      $coUS.WorkAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.WorkAddress2 is valid" {
      if ($coUS.WorkAddress2.Length -gt 0)
      {
        $addr2 = $coUS.WorkAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.WorkCity is valid" {
      $citiesUS | Should -Contain $coUS.WorkCity
    }

    It "<function>.WorkState is valid" {
      $stateAbbrUS | Should -Contain $coUS.WorkState
    }

    It "<function>.WorkPostalCode is valid" {
      $coUS.WorkPostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.BirthDate is valid" {
      $coUS.BirthDate | Should -Match $matchDateYYYYMMDD
    }

  } # Context "<module> <function> US Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for CountryCode UK
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> default country code Tests" {
    It "<function>.FirstName is valid" {
      $namesFirst | Should -Contain $coUK.FirstName
    }

    It "<function>.MiddleName is valid" {
      $namesFirst | Should -Contain $coUK.MiddleName
    }

    It "<function>.LastName is valid" {
      $namesLast | Should -Contain $coUK.LastName
    }

    It "<function>.FullName is valid" {
      $fullName = $coUK.FullName.Split(' ')
      $namesFirst | Should -Contain $fullName[0]
      $namesFirst | Should -Contain $fullName[1]
      $namesLast | Should -Contain $fullName[2]
    }

    It "<function>.CustomerID is valid" {
      $coUK.CustomerID | Should -Match '[A-Z]{2}\d{6}'
    }

    It "<function>.Email is valid" {
      $email = $coUK.Email.Split('@')
      $email[0] | Should -Be "$($($coUK.FirstName).Substring(0, 1).ToLower()).$($($coUK.LastName).ToLower())"
      $email[1] | Should -Be "fakemail.com"
    }

    It "<function>.HomePhone is valid" {
      $coUK.HomePhone | Should -Match $matchPhoneUK
    }

    It "<function>.MobilePhone is valid" {
      $coUK.MobilePhone | Should -Match $matchPhoneUK
    }

    It "<function>.WorkPhone is valid" {
      $coUK.WorkPhone | Should -Match $matchPhoneUK
    }

    It "<function>.HomeAddress1 is valid" {
      $coUK.HomeAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.HomeAddress2 is valid" {
      if ($coUK.HomeAddress2.Length -gt 0)
      {
        $addr2 = $coUK.HomeAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.HomeCity is valid" {
      $citiesUK | Should -Contain $coUK.HomeCity
    }

    It "<function>.HomeState is valid" {
      $stateAbbrUK | Should -Contain $coUK.HomeState
    }

    It "<function>.HomePostalCode is valid" {
      $coUK.HomePostalCode | Should -Match $matchPostalCodeUK
    }

    It "<function>.WorkAddress1 is valid" {
      $coUK.WorkAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.WorkAddress2 is valid" {
      if ($coUK.WorkAddress2.Length -gt 0)
      {
        $addr2 = $coUK.WorkAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.WorkCity is valid" {
      $citiesUK | Should -Contain $coUK.WorkCity
    }

    It "<function>.WorkState is valid" {
      $stateAbbrUK | Should -Contain $coUK.WorkState
    }

    It "<function>.WorkPostalCode is valid" {
      $coUK.WorkPostalCode | Should -Match $matchPostalCodeUK
    }

    It "<function>.BirthDate is valid" {
      $coUK.BirthDate | Should -Match $matchDateYYYYMMDD
    }

  } # Context "<module> <function> UK Tests"

} # Describe DataFabricator Tests