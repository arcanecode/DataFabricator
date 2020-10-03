<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedEmployeeRecord.Tests.ps1
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

Describe "DataFabricator New-FabricatedEmployeeRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedEmployeeRecord'
    $here = $PSScriptRoot

    # RegEx Match Strings
    $matchPostalCodeUS = '\d{5}'
    $matchPhoneUS = '\d{3}-\d{3}-\d{4}'
    $matchTaxpayerIdUS = '\d{3}-\d{2}-\d{4}'

    $matchPostalCodeUK = '[A-Z]{2}\d[A-Z] \d[A-Z]{2}'
    $matchPhoneUK = '\(\d{3}\) \d{4} \d{4}'
    $matchTaxpayerIdMatch = '\d{5} \d{5}'

    $matchDateYYYYMMDD = '\d{4}-\d{2}-\d{2}'
    $matchTimeHHMMSS = '\d{2}:\d{2}:\d{2}'
    $matchTimeHHMMSSAMPM = '\d{2}:\d{2}:\d{2} [AP]M'

    # Load Names
    $namesFirst = Get-Content .\Data\Data-NamesFirst.txt
    $namesLast = Get-Content .\Data\Data-NamesLast.txt

    # Load address 2
    $address2First = Get-Content .\Data\Data-Address2.txt

    # Load Job Titles
    $jobTitle = Get-Content .\Data\Data-JobTitles.txt

    # Load US Data
    $citiesUS = Get-Content .\Data\Data-CitiesUS.txt
    $stateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt

    # Load UK Data
    $citiesUK = Get-Content .\Data\Data-CitiesUK.txt
    $stateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt

    # Generate data to test
    $emDF = New-FabricatedEmployeeRecord
    $emUS = New-FabricatedEmployeeRecord -CountryCode 'US'
    $emUK = New-FabricatedEmployeeRecord -CountryCode 'UK'

  }

  #----------------------------------------------------------------------------------------------
  #  Tests for default country code
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> default country code Tests" {
    It "<function>.FirstName is valid" {
      $namesFirst | Should -Contain $emDF.FirstName
    }

    It "<function>.MiddleName is valid" {
      $namesFirst | Should -Contain $emDF.MiddleName
    }

    It "<function>.LastName is valid" {
      $namesLast | Should -Contain $emDF.LastName
    }

    It "<function>.FullName is valid" {
      $fullName = $emDF.FullName.Split(' ')
      $namesFirst | Should -Contain $fullName[0]
      $namesFirst | Should -Contain $fullName[1]
      $namesLast | Should -Contain $fullName[2]
    }

    It "<function>.TaxpayerID is valid" {
      $emDF.TaxpayerID | Should -Match $matchTaxpayerIDUS
    }

    It "<function>.EmployeeID is valid" {
      $emDF.EmployeeID | Should -Match '[A-Z]{2}\d{4}'
    }

    It "<function>.Email is valid" {
      $email = $emDF.Email.Split('@')
      $email[0] | Should -Be "$($($emDF.FirstName).Substring(0, 1).ToLower()).$($($emDF.LastName).ToLower())"
      $email[1] | Should -Be "fakemail.com"
    }

    It "<function>.HomePhone is valid" {
      $emDF.HomePhone | Should -Match $matchPhoneUS
    }

    It "<function>.MobilePhone is valid" {
      $emDF.MobilePhone | Should -Match $matchPhoneUS
    }

    It "<function>.WorkPhone is valid" {
      $emDF.WorkPhone | Should -Match $matchPhoneUS
    }

    It "<function>.HomeAddress1 is valid" {
      $emDF.HomeAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.HomeAddress2 is valid" {
      if ($emDF.HomeAddress2.Length -gt 0)
      {
        $addr2 = $emDF.HomeAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.HomeCity is valid" {
      $citiesUS | Should -Contain $emDF.HomeCity
    }

    It "<function>.HomeState is valid" {
      $stateAbbrUS | Should -Contain $emDF.HomeState
    }

    It "<function>.HomePostalCode is valid" {
      $emDF.HomePostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.WorkAddress1 is valid" {
      $emDF.WorkAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.WorkAddress2 is valid" {
      if ($emDF.WorkAddress2.Length -gt 0)
      {
        $addr2 = $emDF.WorkAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.WorkCity is valid" {
      $citiesUS | Should -Contain $emDF.WorkCity
    }

    It "<function>.WorkState is valid" {
      $stateAbbrUS | Should -Contain $emDF.WorkState
    }

    It "<function>.WorkPostalCode is valid" {
      $emDF.WorkPostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.BirthDate is valid" {
      $emDF.BirthDate | Should -Match $matchDateYYYYMMDD
    }

    It "<function>.HireDate is valid" {
      $emDF.BirthDate | Should -Match $matchDateYYYYMMDD
    }

    It "<function>.JobTitle is valid" {
      $jobTitle | Should -Contain $emDF.JobTitle
    }

  } # Context "<module> <function> Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for CountryCode US
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -CountryCode US Tests" {
    It "<function>.FirstName is valid" {
      $namesFirst | Should -Contain $emUS.FirstName
    }

    It "<function>.MiddleName is valid" {
      $namesFirst | Should -Contain $emUS.MiddleName
    }

    It "<function>.LastName is valid" {
      $namesLast | Should -Contain $emUS.LastName
    }

    It "<function>.FullName is valid" {
      $fullName = $emUS.FullName.Split(' ')
      $namesFirst | Should -Contain $fullName[0]
      $namesFirst | Should -Contain $fullName[1]
      $namesLast | Should -Contain $fullName[2]
    }

    It "<function>.TaxpayerID is valid" {
      $emUS.TaxpayerID | Should -Match $matchTaxpayerIDUS
    }

    It "<function>.EmployeeID is valid" {
      $emUS.EmployeeID | Should -Match '[A-Z]{2}\d{4}'
    }

    It "<function>.Email is valid" {
      $email = $emUS.Email.Split('@')
      $email[0] | Should -Be "$($($emUS.FirstName).Substring(0, 1).ToLower()).$($($emUS.LastName).ToLower())"
      $email[1] | Should -Be "fakemail.com"
    }

    It "<function>.HomePhone is valid" {
      $emUS.HomePhone | Should -Match $matchPhoneUS
    }

    It "<function>.MobilePhone is valid" {
      $emUS.MobilePhone | Should -Match $matchPhoneUS
    }

    It "<function>.WorkPhone is valid" {
      $emUS.WorkPhone | Should -Match $matchPhoneUS
    }

    It "<function>.HomeAddress1 is valid" {
      $emUS.HomeAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.HomeAddress2 is valid" {
      if ($emUS.HomeAddress2.Length -gt 0)
      {
        $addr2 = $emUS.HomeAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.HomeCity is valid" {
      $citiesUS | Should -Contain $emUS.HomeCity
    }

    It "<function>.HomeState is valid" {
      $stateAbbrUS | Should -Contain $emUS.HomeState
    }

    It "<function>.HomePostalCode is valid" {
      $emUS.HomePostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.WorkAddress1 is valid" {
      $emUS.WorkAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.WorkAddress2 is valid" {
      if ($emUS.WorkAddress2.Length -gt 0)
      {
        $addr2 = $emUS.WorkAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.WorkCity is valid" {
      $citiesUS | Should -Contain $emUS.WorkCity
    }

    It "<function>.WorkState is valid" {
      $stateAbbrUS | Should -Contain $emUS.WorkState
    }

    It "<function>.WorkPostalCode is valid" {
      $emUS.WorkPostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.BirthDate is valid" {
      $emUS.BirthDate | Should -Match $matchDateYYYYMMDD
    }

    It "<function>.HireDate is valid" {
      $emUS.BirthDate | Should -Match $matchDateYYYYMMDD
    }

    It "<function>.JobTitle is valid" {
      $jobTitle | Should -Contain $emDF.JobTitle
    }

  } # Context "<module> <function> -CountryCode US Tests"

  #----------------------------------------------------------------------------------------------
  #  Tests for CountryCode UK
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -CountryCode US Tests" {
    It "<function>.FirstName is valid" {
      $namesFirst | Should -Contain $emUK.FirstName
    }

    It "<function>.MiddleName is valid" {
      $namesFirst | Should -Contain $emUK.MiddleName
    }

    It "<function>.LastName is valid" {
      $namesLast | Should -Contain $emUK.LastName
    }

    It "<function>.FullName is valid" {
      $fullName = $emUK.FullName.Split(' ')
      $namesFirst | Should -Contain $fullName[0]
      $namesFirst | Should -Contain $fullName[1]
      $namesLast | Should -Contain $fullName[2]
    }

    It "<function>.TaxpayerID is valid" {
      $emUK.TaxpayerID | Should -Match $matchTaxpayerIDUK
    }

    It "<function>.EmployeeID is valid" {
      $emUK.EmployeeID | Should -Match '[A-Z]{2}\d{4}'
    }

    It "<function>.Email is valid" {
      $email = $emUK.Email.Split('@')
      $email[0] | Should -Be "$($($emUK.FirstName).Substring(0, 1).ToLower()).$($($emUK.LastName).ToLower())"
      $email[1] | Should -Be "fakemail.com"
    }

    It "<function>.HomePhone is valid" {
      $emUK.HomePhone | Should -Match $matchPhoneUK
    }

    It "<function>.MobilePhone is valid" {
      $emUK.MobilePhone | Should -Match $matchPhoneUK
    }

    It "<function>.WorkPhone is valid" {
      $emUK.WorkPhone | Should -Match $matchPhoneUK
    }

    It "<function>.HomeAddress1 is valid" {
      $emUK.HomeAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.HomeAddress2 is valid" {
      if ($emUK.HomeAddress2.Length -gt 0)
      {
        $addr2 = $emUK.HomeAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.HomeCity is valid" {
      $citiesUK | Should -Contain $emUK.HomeCity
    }

    It "<function>.HomeState is valid" {
      $stateAbbrUK | Should -Contain $emUK.HomeState
    }

    It "<function>.HomePostalCode is valid" {
      $emUK.HomePostalCode | Should -Match $matchPostalCodeUK
    }

    It "<function>.WorkAddress1 is valid" {
      $emUK.WorkAddress1.Length | Should -BeGreaterThan 0
    }

    It "<function>.WorkAddress2 is valid" {
      if ($emUK.WorkAddress2.Length -gt 0)
      {
        $addr2 = $emUK.WorkAddress2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.WorkCity is valid" {
      $citiesUK | Should -Contain $emUK.WorkCity
    }

    It "<function>.WorkState is valid" {
      $stateAbbrUK | Should -Contain $emUK.WorkState
    }

    It "<function>.WorkPostalCode is valid" {
      $emUK.WorkPostalCode | Should -Match $matchPostalCodeUK
    }

    It "<function>.BirthDate is valid" {
      $emUK.BirthDate | Should -Match $matchDateYYYYMMDD
    }

    It "<function>.HireDate is valid" {
      $emUK.BirthDate | Should -Match $matchDateYYYYMMDD
    }

    It "<function>.JobTitle is valid" {
      $jobTitle | Should -Contain $emDF.JobTitle
    }

  } # Context "<module> <function> -CountryCode UK Tests"

} # Describe DataFabricator Tests