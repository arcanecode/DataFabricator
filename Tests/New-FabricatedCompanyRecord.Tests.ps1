<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedCompanyRecord.Tests.ps1
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

Describe "DataFabricator New-FabricatedCompanyRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedCompanyRecord'
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

    # Load Company Info
    $companyFirst = Get-Content .\Data\Data-CompanyNamePrefix.txt
    $companyIndustry = Get-Content .\Data\Data-CompanyIndustry.txt
    $companyLast = Get-Content .\Data\Data-CompanyType.txt

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
    $coDF = New-FabricatedCompanyRecord
    $coUS = New-FabricatedCompanyRecord -CountryCode 'US'
    $coUK = New-FabricatedCompanyRecord -CountryCode 'UK'
  }

  #----------------------------------------------------------------------------------------------
  #  Tests with Default Country Code
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> Tests for Default Country Code" {
    It "<function>.Name is valid" {
      $name = $coDF.Name.Split(" ")
      # Some industries have a space in the name. If three elements are returned, no space.
      # If four, then elements 1 and 2 need to be recombined
      if ( $name.Length -eq 3 )
      {
        $companyFirst | Should -Contain $name[0]
        $companyIndustry | Should -Contain $name[1]
        $companyLast | Should -Contain $name[2]
      }
      else
      {
        $companyFirst | Should -Contain $name[0]
        $companyIndustry | Should -Contain "$($name[1]) $($name[2])"
        $companyLast | Should -Contain $name[3]
      }
    }

    It "<function>.Address1 is present" {
      # Since address is so variable, we'll just make sure one was returned
      $coDF.Address1.Length | Should -BeGreaterThan 0
    }

    It "<function>.Address2 is valid, if it is present" {
      # Since address is so variable, we'll just make sure one was returned
      if ($coDF.Address2.Length -gt 0)
      {
        $addr2 = $coDF.Address2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.City is valid" {
      $citiesUS | Should -Contain $coDF.City
    }

    It "<function>.State is valid" {
      $stateAbbrUS | Should -Contain $coDF.State
    }

    It "<function>.PostalCode is valid" {
      $coDF.PostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.ContactName is valid" {
      $name = $coDF.ContactName.Split(" ")
      $namesFirst | Should -Contain $name[0]
      $namesLast | Should -Contain $name[1]
    }

    It "<function>.ContactPhone is valid" {
      $coDF.ContactPhone | Should -Match $matchPhoneUS
    }

    It "<function>.ContactEmail is valid" {
      $email = $coDF.ContactEmail.Split('@')
      $name = $coDF.ContactName.Split(' ')
      $email[0] | Should -Be "$($name[0].Substring(0, 1).ToLower()).$($name[1].ToLower())"
      $email[1] | Should -Be "$($coDF.Name.ToLower().Replace(' ', '')).com"
    }

    It "<function>.JobTitle is valid" {
      $jobTitle | Should -Contain $coDF.ContactJobTitle
    }

  } # Context "<module> <function> Tests"

  #----------------------------------------------------------------------------------------------
  #  US Tests
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -CountryCode US Tests" {
    It "<function>.Name is valid" {
      $name = $coUS.Name.Split(" ")
      # Some industries have a space in the name. If three elements are returned, no space.
      # If four, then elements 1 and 2 need to be recombined
      if ( $name.Length -eq 3 )
      {
        $companyFirst | Should -Contain $name[0]
        $companyIndustry | Should -Contain $name[1]
        $companyLast | Should -Contain $name[2]
      }
      else
      {
        $companyFirst | Should -Contain $name[0]
        $companyIndustry | Should -Contain "$($name[1]) $($name[2])"
        $companyLast | Should -Contain $name[3]
      }
    }

    It "<function>.Address1 is present" {
      # Since address is so variable, we'll just make sure one was returned
      $coUS.Address1.Length | Should -BeGreaterThan 0
    }

    It "<function>.Address2 is valid, if it is present" {
      # Since address is so variable, we'll just make sure one was returned
      if ($coUS.Address2.Length -gt 0)
      {
        $addr2 = $coUS.Address2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.City is valid" {
      $citiesUS | Should -Contain $coUS.City
    }

    It "<function>.State is valid" {
      $stateAbbrUS | Should -Contain $coUS.State
    }

    It "<function>.PostalCode is valid" {
      $coUS.PostalCode | Should -Match $matchPostalCodeUS
    }

    It "<function>.ContactName is valid" {
      $name = $coDF.ContactName.Split(" ")
      $namesFirst | Should -Contain $name[0]
      $namesLast | Should -Contain $name[1]
    }

    It "<function>.ContactPhone is valid" {
      $coUS.ContactPhone | Should -Match $matchPhoneUS
    }

    It "<function>.ContactEmail is valid" {
      $email = $coUS.ContactEmail.Split('@')
      $name = $coUS.ContactName.Split(' ')
      $email[0] | Should -Be "$($name[0].Substring(0, 1).ToLower()).$($name[1].ToLower())"
      $email[1] | Should -Be "$($coUS.Name.ToLower().Replace(' ', '')).com"
    }

    It "<function>.JobTitle is valid" {
      $jobTitle | Should -Contain $coUS.ContactJobTitle
    }

  } # Context "<module> <function> -CountryCode US Tests"

  #----------------------------------------------------------------------------------------------
  #  UK Tests
  #----------------------------------------------------------------------------------------------

  Context "<module> <function> -CountryCode UK Tests" {
    It "<function>.Name is valid" {
      $name = $coUK.Name.Split(" ")
      # Some industries have a space in the name. If three elements are returned, no space.
      # If four, then elements 1 and 2 need to be recombined
      if ( $name.Length -eq 3 )
      {
        $companyFirst | Should -Contain $name[0]
        $companyIndustry | Should -Contain $name[1]
        $companyLast | Should -Contain $name[2]
      }
      else
      {
        $companyFirst | Should -Contain $name[0]
        $companyIndustry | Should -Contain "$($name[1]) $($name[2])"
        $companyLast | Should -Contain $name[3]
      }
    }

    It "<function>.Address1 is present" {
      # Since address is so variable, we'll just make sure one was returned
      $coUK.Address1.Length | Should -BeGreaterThan 0
    }

    It "<function>.Address2 is valid, if it is present" {
      # Since address is so variable, we'll just make sure one was returned
      if ($coUK.Address2.Length -gt 0)
      {
        $addr2 = $coUK.Address2.Split(' ')
        $address2First | Should -Contain $addr2[0]
      }
      else
      {
        $true | Should -BeTrue
      }
    }

    It "<function>.City is valid" {
      $citiesUK | Should -Contain $coUK.City
    }

    It "<function>.State is valid" {
      $stateAbbrUK | Should -Contain $coUK.State
    }

    It "<function>.PostalCode is valid" {
      $coUK.PostalCode | Should -Match $matchPostalCodeUK
    }

    It "<function>.ContactName is valid" {
      $name = $coDF.ContactName.Split(" ")
      $namesFirst | Should -Contain $name[0]
      $namesLast | Should -Contain $name[1]
    }

    It "<function>.ContactPhone is valid" {
      $coUK.ContactPhone | Should -Match $matchPhoneUK
    }

    It "<function>.ContactEmail is valid" {
      $email = $coUK.ContactEmail.Split('@')
      $name = $coUK.ContactName.Split(' ')
      $email[0] | Should -Be "$($name[0].Substring(0, 1).ToLower()).$($name[1].ToLower())"
      $email[1] | Should -Be "$($coUK.Name.ToLower().Replace(' ', '')).com"
    }

    It "<function>.JobTitle is valid" {
      $jobTitle | Should -Contain $coUK.ContactJobTitle
    }

  } # Context "<module> <function> -CountryCode UK Tests"

} # Describe DataFabricator Tests
