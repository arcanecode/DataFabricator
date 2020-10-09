<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-TableProducts.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script creates hash tables for each part of a product (color, clothing type, and size).
  It is used in the ConvertFrom-ProductCode function.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Used in the ConvertFrom-ProductCode function

$m_ColorCodes = @{}
foreach($c in $m_Colors)
{
  $m_ColorCodes[$($c.Substring(0,3).ToUpper())] = $c
}

$m_ClothingCodes = @{}
foreach($c in $m_Clothing)
{
  $m_ClothingCodes[$($c.Substring(0,3).ToUpper())] = $c
}

$m_SizeCodes = @{}
foreach($s in $m_Sizes)
{
  $m_SizeCodes[$($s.Substring(0,3).ToUpper())] = $s
}
