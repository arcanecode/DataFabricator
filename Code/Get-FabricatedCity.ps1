<#
.SYNOPSIS
Fabricates the name of a city from a list of cities.

.DESCRIPTION
This routine will generate the name of a city from an internal list for use in your fabricated data.

.PARAMETER CountryCode
Country code. If no code is supplied it defaults to the US.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the name of a city.

.EXAMPLE
Get-FabricatedCity

Get-FabricatedCity returns data similar to the following example:

City | Chelsea

.EXAMPLE
Get-FabricatedCity -CountryCode UK

Get-FabricatedCity returns data similar to the following example:

City | Inverness

.NOTES
Data Fabricator - Get-FabricatedCity.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStatePostalCodeRecord.md

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
  param (
          [string] $CountryCode = 'US'
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CountryCode: $CountryCode
"@

  # If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  switch ( $CountryCode )
  {
    'UK'    { $retVal = $m_CitiesUK | Get-Random }
    'US'    { $retVal = $m_CitiesUS | Get-Random }
    default { $retVal = $m_CitiesUS | Get-Random }
  }

  Write-Verbose "$fn Fabricated City: $retVal"

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  # Return our results
  return $retVal

}