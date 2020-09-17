<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Execute-Tests.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This script will execute the pester tests located in the Tests folder.

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author. 
-----------------------------------------------------------------------------------------------#>

# On Windows an older version of Pester is included with Windows. We need these switches
# so the new version can be installed. It will supercede the old version.
# On Linux/Mac it's not needed, but won't hurt anything
Install-Module Pester -Force 
Import-Module Pester

# Before running, you need to have the most current version loaded in memory
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator 

$tests = "$pwd\Tests"

Invoke-Pester "$tests\DataFabricator.Module.Tests.ps1"
