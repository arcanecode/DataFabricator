<#
.SYNOPSIS
Fabricates a US state by randomly picking it from a list of states.

.DESCRIPTION
We're not talking about a state of mind here, but the state where someone lives, or in our case pretends to live.

This cmdlet will randomly select a state and returns the two character code for that state.
Alternativley it can also return the full name of a state by using the FullName switch.

.PARAMETER FullName
Switch that will return the full name of a state instead of the two character state abbreviation.

.PARAMETER CountryCode
Country code. If no code is supplied it defaults to the US.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with a randomly selected US state.

.EXAMPLE
Get-FabricatedState

Get-FabricatedState returns data similar to the following example:

State | AL

.EXAMPLE
Get-FabricatedState -FullName

Get-FabricatedState returns data similar to the following example:

State | Alabama

.EXAMPLE
Get-FabricatedState -CountryCode UK

Get-FabricatedState returns data similar to the following example:

State | WO

.EXAMPLE
Get-FabricatedState -FullName -CountryCode UK

Get-FabricatedState returns data similar to the following example:

State | Yorkshire

.NOTES
Data Fabricator - Get-FabricatedState.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md

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

function Get-FabricatedState()
{
  [CmdletBinding()]
  param (
          [switch] $FullName
        , [string] $CountryCode = 'US'
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Country Code............................................: $CountryCode
         Return the full state name instead of the abbreviation..: $($FullName.IsPresent)
"@

  #----------------------------------------------------------------------------------------------
  # Some helper functions
  #----------------------------------------------------------------------------------------------
  function usState( [bool] $fullName )
  {
    if ($fullName)
      { $retVal = $m_StateNameUS | Get-Random }
    else 
      { $retVal = $m_StateAbbrUS | Get-Random }

    return $retVal
  }

  function ukState( [bool] $fullName )
  {
    if ($fullName)
      { $retVal = $m_StateNameUK | Get-Random }
    else 
      { $retVal = $m_StateAbbrUK | Get-Random }

    return $retVal
  }

  #----------------------------------------------------------------------------------------------
  #  Main logic to create and return the State
  #----------------------------------------------------------------------------------------------

  # If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }


  switch ($CountryCode) {
    'UK'    { $retVal = ukState( $FullName.IsPresent) }
    'US'    { $retVal = usState( $FullName.IsPresent) }
    default { $retVal = usState( $FullName.IsPresent) }
  }

  Write-Verbose "$fn Fabricated State $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}