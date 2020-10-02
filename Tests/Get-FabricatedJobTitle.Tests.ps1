<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Get-FabricatedJobTitle.Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

Describe "DataFabricator Get-FabricatedJobTitle Tests" {

  BeforeAll {
    $module = 'DataFabricator'
    $function = 'Get-FabricatedJobTitle'
    $here = $PSScriptRoot

    # Load Job Titles
    $jobTitle = Get-Content .\Data\Data-JobTitles.txt

  }

  Context "<module> <function> Tests" {
    It "<function> is in the list of Job Titles" {
      $jobTitle | Should -Contain $(Get-FabricatedJobTitle)
    }

  } # Context "<module> <function> Tests"

} # Describe DataFabricator Tests