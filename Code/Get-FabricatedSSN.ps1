<#
.SYNOPSIS
Fabricates a SSN (Social Security Number), a taxpayer identification number used in the US.

.DESCRIPTION
Will generate a US based taxpayer Social Security Number (abbreviated SSN) in the format xxx-xx-xxxx.

.PARAMETER NoDashes
Switch that will prevent dashes from being included in the output.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the fabricated SSN.

.EXAMPLE
Get-FabricatedSSN

Get-FabricatedSSN returns the following data:

082-12-7296

.EXAMPLE
Get-FabricatedSSN -NoDashes

Get-FabricatedSSN returns the following data:

082127296

.NOTES
Data Fabricator - Get-FabricatedSSN.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedSSN()
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

  # Calculate a SSN
  $first = (0..999  | Get-Random).ToString().PadLeft( 3, '0')
  $mid   = (0..99   | Get-Random).ToString().PadLeft( 2, '0')
  $last  = (0..9999 | Get-Random).ToString().PadLeft( 4, '0')

  if ( $NoDashes.IsPresent )
  {
    $retVal = "$($first)$($mid)$($last)"
  }
  else
  {
    $retVal = "$first-$mid-$last"
  }

  Write-Verbose "$fn Fabricated SSN $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}