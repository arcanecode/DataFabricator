<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Export-Documentation.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This file is used to generate (or regenerate) the Markdown Documenation from the
  inline help using the PlatyPS module. 

  Before running you will need to install PlatyPS, available from the PSGallery.
  Install-Module PlatyPS

  Learn more about PlatyPS at: 
  https://github.com/PowerShell/platyPS

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author. 
-----------------------------------------------------------------------------------------------#>

# Import PlatyPS into memory
Import-Module PlatyPS

# Before running, you need to have the most current version loaded in memory
Remove-Module DataFabricator -ErrorAction SilentlyContinue
Import-Module .\DataFabricator 

# Now generate the documentation (Force is needed to overwrite existing documentation)
# Note this will overwrite any changes you manually made
New-MarkdownHelp -Module DataFabricator -OutputFolder ".\Documentation" -Force -WithModulePage -AlphabeticParamsOrder

Update-MarkdownHelp -Path ".\Documentation"

# This will update existing help or create files for new cmdlets
Update-MarkdownHelpModule -Path ".\Documentation"
