<#
.SYNOPSIS
Converts the state abbreviation to the full state name.

.DESCRIPTION
State abbreviations can be confusing, I mean is AL Alabama or Alaska? Who has time to remember stuff like that.

To avoid confusion, this cmdlet takes the passed in the two character state abbreviation, and expands it to the full state name. 
The country code is also needed to know which set of state tables to use (US, UK, etc).

.PARAMETER CountryCode
Country code. If no code is supplied it defaults to the US.

.PARAMETER StateAbbr
The two character state abbreviation.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the expanded state name. It will be empty if the passed in state abbreviation is not found.

.EXAMPLE
Get-StateName -StateAbbr 'AL' -CountryCode 'US'

returns data similar to the following example:

StateName | Alabama

.EXAMPLE
Get-StateName -StateAbbr 'CA' -CountryCode 'UK'

returns data similar to the following example:

StateName | Cambridgeshire

.NOTES
Data Fabricator - Get-StateName.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/CMDLET-HERE.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-StateName()
{
  [CmdletBinding()]
  param (
          [string] $StateAbbr
        , [string] $CountryCode = 'US'
        )

  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         State Abbreviation..: $StateAbbr
         Country Code........: $CountryCode
"@

# If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  switch ($CountryCode) {
    'UK'    { $retVal = $m_StateTableUK[$StateAbbr] }
    'US'    { $retVal = $m_StateTableUS[$StateAbbr] }
    default { $retVal = $m_StateTableUS[$StateAbbr] }
  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}
