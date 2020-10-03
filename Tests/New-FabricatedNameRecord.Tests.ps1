<#-------------------------------------------------------------------------------------------------
  Data Fabricator - New-FabricatedNameRecord.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator New-FabricatedNameRecord.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'New-FabricatedNameRecord'
    $here = $PSScriptRoot

    # Load Names
    $namesFirst = Get-Content .\Data\Data-NamesFirst.txt
    $namesLast = Get-Content .\Data\Data-NamesLast.txt
    $letter = 'A'..'Z'

    # Get a record for testing
    $namerec = New-FabricatedNameRecord

    $namerecords = New-FabricatedNameRecord -RecordCount 5

  }

  Context "<module> <function> Tests" {
    It "<function> -RecordCount 5 returns 5 rows" {
      $namerecords.Count | Should -BeExactly 5
    }

    It "<function>.First is a valid value" {
      $namesFirst | Should -Contain $namerec.First
    }

    It "<function>.Middle is a valid value" {
      $namesFirst | Should -Contain $namerec.Middle
    }

    It "<function>.Last is a valid value" {
      $namesLast | Should -Contain $namerec.Last
    }

    It "<function>.FirstLast is a valid value" {
      $name = $namerec.FirstLast.Split(' ')
      $namesFirst | Should -Contain $name[0]
      $namesLast | Should -Contain $name[1]
    }

    It "<function>.FirstMiLast is a valid value" {
      $name = $namerec.FirstMiLast.Split(' ')
      $namesFirst | Should -Contain $name[0]
      $letter | Should -Contain $name[1].Substring(0, 1)
      $namesLast | Should -Contain $name[2]
    }

    It "<function>.FirstMiddleLast is a valid value" {
      $name = $namerec.FirstMiddleLast.Split(' ')
      $namesFirst | Should -Contain $name[0]
      $namesFirst | Should -Contain $name[1]
      $namesLast | Should -Contain $name[2]
    }

    It "<function>.LastFirst is a valid value" {
      $name = $namerec.LastFirst.Split(', ')
      $namesLast | Should -Contain $name[0]
      $namesFirst | Should -Contain $name[1]
    }

    It "<function>.LastFirstMi is a valid value" {
      # First split on , to break last from rest of name
      $lastfirstmi = $namerec.LastFirstMi.Split(', ')
      # Now split the first and middle apart
      $firstmi = $lastfirstmi[1].Split(' ')
      $namesLast | Should -Contain $lastfirstmi[0]
      $namesFirst | Should -Contain $firstmi[0]
      $letter | Should -Contain $firstmi[1].Substring(0, 1)
    }

    It "<function>.LastFirstMiddle is a valid value" {
      # First split on , to break last from rest of name
      $lastfirstmi = $namerec.LastFirstMiddle.Split(', ')
      # Now split the first and middle apart
      $firstmi = $lastfirstmi[1].Split(' ')
      $namesLast | Should -Contain $lastfirstmi[0]
      $namesFirst | Should -Contain $firstmi[0]
      $namesFirst | Should -Contain $firstmi[1]
    }

    It "<function>.EmailName is a valid value" {
      $name = $namerec.EmailName.Split('.')
      $letter | Should -Contain $name[0]
      $namesLast | Should -Contain $name[1]
    }

    It "<function>.NameCode is a valid value" {
      $name = $namerec.NameCode.Split('_')
      $namesLast | Should -Contain $name[0]
      $namesFirst | Should -Contain $name[1]
      $namesFirst | Should -Contain $name[2]
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests