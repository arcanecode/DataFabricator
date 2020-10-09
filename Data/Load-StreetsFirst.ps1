<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-StreetsFirst.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script loads the first part of a street name, used in fabricating addresses.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# This is the first half of a street address, for example "Oak" or "1st".
# The street address last holds things like "Ave" "Lane" etc.

$m_StreetsFirst = Get-Content .\Data\Data-StreetsFirst.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxStreetsFirstLength = ($m_StreetsFirst | Measure-Object -Maximum -Property Length).Maximum
