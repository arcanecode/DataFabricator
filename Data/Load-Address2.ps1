<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-Address2.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script loads the data in Address2 into memory. It is used to fabricate the second line
  of an address.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# First part of an Address 2, to be combined with a letter or number
# Example: Suite 101 or Apartment A

$m_Address2First = Get-Content .\Data\Data-Address2.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these 'constants' here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxAddress2FirstLength = ($m_Address2First | Measure-Object -Maximum -Property Length).Maximum
