<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-States.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script loads lists of states and their abbreviations.

  Note: Yes, we know the UK doesn't really have "states". For the time being we've used UK
  counties, and fabricated some bogus two letter abbreviations. In a future version of
  DataFabricator we plan to fix this.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Load State Abbreviations and Names

$m_StateAbbrUS = Get-Content .\Data\Data-StateAbbrUS.txt
$m_StateNameUS = Get-Content .\Data\Data-StateNameUS.txt

# Since we want this to be a hashtable we need to include -Raw so 
# ConvertFrom-StringData will return a hashtable datatype
$m_StateTableUS = Get-Content -Raw .\Data\Data-StateTableUS.txt | ConvertFrom-StringData

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxStateAbbrUSLength = ($m_StateAbbrUS | Measure-Object -Maximum -Property Length).Maximum
$c_MaxStateNameUSLength = ($m_StateNameUS | Measure-Object -Maximum -Property Length).Maximum


$m_StateAbbrUK = Get-Content .\Data\Data-StateAbbrUK.txt
$m_StateNameUK = Get-Content .\Data\Data-StateNameUK.txt
$m_StateTableUK = Get-Content -Raw .\Data\Data-StateTableUK.txt | ConvertFrom-StringData
