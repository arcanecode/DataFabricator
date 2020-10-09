<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-Products.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  For products in DataFabricator, we've gone with the generic product of clothing. This script
  loads colors, clothing type (shirts, pants etc.) and sizes. The three are then used to
  randomly generate a product.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

$m_Colors = Get-Content .\Data\Data-Colors.txt

$m_Clothing = Get-Content .\Data\Data-Clothing.txt

$m_Sizes = Get-Content .\Data\Data-Sizes.txt

# Some functions use the length of a string for calculating spaces for
# proper on screen formatting. By calculating these "constants" here,
# you can freely add or alter values in the above arrays without concern
# of adversely affecting the functions in the module
$c_MaxColorLength = ($m_Colors | Measure-Object -Maximum -Property Length).Maximum
$c_MaxClothingLength = ($m_Clothing | Measure-Object -Maximum -Property Length).Maximum
$c_MaxSizeLength = ($m_Sizes | Measure-Object -Maximum -Property Length).Maximum


