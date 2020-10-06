<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedName.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator Get-FabricatedName.Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedName'
    $here = $PSScriptRoot
    $namesFirst = Get-Content .\Data\Data-NamesFirst.txt
    $namesLast = Get-Content .\Data\Data-NamesLast.txt
    $letter = 'A'..'Z'

  }

  Context "<module> <function> Tests" {
    It "<function> returns a valid first and last name" {
      # Example: John Doe
      $name = $(Get-FabricatedName).Split(" ")
      $namesFirst | Should -Contain  $name[0]
      $namesLast | Should -Contain  $name[1]
    }

    It "<function> -First returns a valid first name" {
      # Example: John
      $namesFirst | Should -Contain  $(Get-FabricatedName -First)
    }

    It "<function> -Last returns a valid last name" {
      # Example: Doe
      $namesLast | Should -Contain  $(Get-FabricatedName -Last)
    }

    It "<function> -FirstMiLast returns a valid first, middle initial, and last name" {
      # Example: John X. Doe
      $name = $(Get-FabricatedName -FirstMiLast).Split(" ")
      $namesFirst | Should -Contain  $name[0]
      $letter | Should -Contain $name[1].Substring(0,1)
      $namesLast | Should -Contain  $name[2]
    }

    It "<function> -FirstMiddleLast returns a valid first, middle, and last name" {
      # Example: John Xavier Doe
      $name = $(Get-FabricatedName -FirstMiddleLast).Split(" ")
      $namesFirst | Should -Contain  $name[0]
      $namesFirst | Should -Contain $name[1]
      $namesLast | Should -Contain  $name[2]
    }

    It "<function> -LastFirst returns a valid last and first name" {
      # Example: Doe, John
      $name = $(Get-FabricatedName -LastFirst).Split(", ")
      $namesLast | Should -Contain  $name[0]
      $namesFirst | Should -Contain  $name[1]
    }

    It "<function> -LastFirstMi returns a valid last, first, middle initial name" {
      # Example: Doe, John X.
      $name = $(Get-FabricatedName -LastFirstMi).Split(" ")
      $namesLast | Should -Contain  $name[0].Substring(0, $name[0].Length -1)
      $namesFirst | Should -Contain  $name[1]
      $letter | Should -Contain $name[2].Substring(0,1)
    }

    It "<function> -LastFirstMiddle returns a valid last, first, middle name" {
      # Example: Doe, John Xavier
      $name = $(Get-FabricatedName -LastFirstMiddle).Split(" ")
      $namesLast | Should -Contain  $name[0].Substring(0, $name[0].Length -1)
      $namesFirst | Should -Contain  $name[1]
      $namesFirst | Should -Contain $name[2]
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests