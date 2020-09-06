<#
.SYNOPSIS
Fabricates the name of a city from a list of cities.

.DESCRIPTION
This routine will generate the name of a city for use in your fabricated data.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the name of a city.

.EXAMPLE
Get-FabricatedCity

Get-FabricatedCity returns the following data:

City: Chelsea

.NOTES
Data Fabricator - Get-FabricatedCity.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipCodeRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedCity()
{
  [CmdletBinding()]
  param ()

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  $retVal = $m_Cities | Get-Random 

  Write-Verbose "$fn Fabricated City: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal 

}