<#
.SYNOPSIS
Taks a city name and creates a city code

.DESCRIPTION
The city code is combined with the two character state abbreviaion to create the city state code.
This is used as a key in several functions.

.PARAMETER City
The name of the city to create a city code for

.INPUTS
This has no inputs

.OUTPUTS
String with the CityCode

.EXAMPLE
ConvertTo-CityCode -City "Aaronsburg CDP"

ConvertTo-CityCode returns the following data:

CityCode: AARONSBURGCDP

.NOTES
Data Fabricator - ConvertTo-CityCode.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipCodeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function ConvertTo-CityCode()
{
  [CmdletBinding()]
  param (
          [string] $City
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CityStateCode: $CityStateCode
"@

  $retVal = $City.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()
  Write-Verbose "$fn City Code: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}