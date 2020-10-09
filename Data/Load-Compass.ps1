<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-Compass.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script loads the compass directions, used in generating addresses.
  (For example, 5th Ave North, or Elm Street NW)

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

$m_Compass = Get-Content .\Data\Data-Compass.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxCompassLength = ($m_Compass | Measure-Object -Maximum -Property Length).Maximum
