<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-Cities.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This loads the list of cities used in the module for fabricating data.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Load US Cities
$m_CitiesUS = Get-Content .\Data\Data-CitiesUS.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxCitiesUSLength = ($m_CitiesUS | Measure-Object -Maximum -Property Length).Maximum

# Load UK Cities
$m_CitiesUK = Get-Content .\Data\Data-CitiesUK.txt
$c_MaxCitiesUKLength = ($m_CitiesUK | Measure-Object -Maximum -Property Length).Maximum
