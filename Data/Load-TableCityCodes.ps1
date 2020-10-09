<#-------------------------------------------------------------------------------------------------
  Data Fabricator - Load-TableCityCodes.ps1
  Author: Robert C. Cain | @ArcaneCode | arcane@arcanetc.com
           http://arcanecode.me

  This code is Copyright (c) 2020 Robert C. Cain. All rights reserved.

  This script takes all of the cities, and uses the DataFabrciator function ConvertTo-CityCode
  to generate an array of city codes.

  The code herein is for demonstration purposes. No warranty or guarantee
  is implied or expressly granted.

  This module may not be reproduced in whole or in part without the express
  written consent of the author.
-----------------------------------------------------------------------------------------------#>

# Load a hashtable of codes and cities
$m_CityCodesUS = @{}

foreach($c in $m_CitiesUS)
{
  $m_CityCodesUS[$(ConvertTo-CityCode -City $c)] = $c
}

# Note since this is a hash table, we won't be calculating max length
# constants, instead you can use the ones for the
# source cities table $c_MaxCitiesLength

$m_CityCodesUK = @{}

foreach($c in $m_CitiesUK)
{
  $m_CityCodesUK[$(ConvertTo-CityCode -City $c)] = $c
}
