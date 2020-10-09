<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-AboutMessages.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  Loads About messages from text files. Putting them in text files makes them easier to update.

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

$m_aboutFunctions = Get-Content ./Data/Data-AboutFunctions.txt -Raw

$m_aboutDataFabricator = Get-Content ./Data/Data-AboutMessage.txt -Raw