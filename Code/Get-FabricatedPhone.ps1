<#
.SYNOPSIS
Fabricates a phone number in xxx-xxx-xxxx (US Based) format.

.DESCRIPTION
Generates three sets of random numbers and combines them to form a phone number.
By default the three sections are separated by dashes, however using a swtich the dash can be excluded from the output.

.PARAMETER NoDashes
Switch that prevents dashses from being included in the returned phone number.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String containing the fabricated phone number.

.EXAMPLE
Get-FabricatedPhone

Get-FabricatedPhone returns the following data:

Phone | 672-344-1425

.EXAMPLE
Get-FabricatedPhone -NoDashes

Get-FabricatedPhone returns the following data:

Phone | 6723441425

.NOTES
Data Fabricator - Get-FabricatedPhone.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCompanyRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedPhone()
{
  [CmdletBinding()]
  param (
          [switch] $NoDashes
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # (US Phones don't start with 0)
  $first = (100..999 | Get-Random).ToString().PadLeft( 3, '0')
  $mid   = (0..999   | Get-Random).ToString().PadLeft( 3, '0')
  $last  = (0..9999  | Get-Random).ToString().PadLeft( 4, '0')

  if ( $NoDashes.IsPresent )
  {
    $retVal = "$($first)$($mid)$($last)"
  }
  else
  {
    $retVal = "$first-$mid-$last"
  }

  Write-Verbose "$fn Fabricated Phone $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}