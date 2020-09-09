<#
.SYNOPSIS
Returns a list of all valid Country Codes

.DESCRIPTION
Returns a list of all valid Country Codes for use with the cmdlets in this module.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Array of country codes.

.EXAMPLE
Get-CountryCodes

Here is a sample of the data.

CountryCode | Unspecified
CountryCode | US
CountryCode | UK

.NOTES
Data Fabricator - Get-CountryCodes.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Test-CountryCode.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-CountryCodes()
{
  [CmdletBinding()]
  param (
        ) 


  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $m_CountryCode

}
