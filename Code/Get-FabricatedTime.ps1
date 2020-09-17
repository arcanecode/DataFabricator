<#
.SYNOPSIS
Fabricates a random time of day.

.DESCRIPTION
The clock is ticking, even for us. To get a time, we need to generate a fake time, which this cmdlet handles.
It will generate a time of day, by default in HH:MM:SS 24 hour format. 
Using a switch it can also return the time in 12 hour AM/PM format.

.PARAMETER AMPM
Switch that will cause the time to be returned in 12 hour format with AM or PM at the end of the string, as opposed to the default of 24 hour format.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with a fabricated time.

.EXAMPLE
Get-FabricatedTime

Get-FabricatedTime returns data similar to the following example:

Time | 22:35:41

.EXAMPLE
Get-FabricatedTime -AMPM

Get-FabricatedTime returns data similar to the following example:

Time | 10:35:41 PM

.NOTES
Data Fabricator - Get-FabricatedTime.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedDate.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedTime()
{
  [CmdletBinding()]
  param (
          [switch] $AMPM
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Use AM/PM: $($AMPM.IsPresent)
"@

  $hour = 0..23 | Get-Random
  $minute = 0..59 | Get-Random
  $second = 0..59 | Get-Random
  $AP = ''

  $minuteStr = $minute.ToString().PadLeft(2, '0')
  $secondStr = $second.ToString().PadLeft(2, '0')

  if ( $AMPM.IsPresent )
  {
    if ( $hour -ge 12 )
    {
      $hour = $hour - 12
      $AP = 'PM'
    }
    else 
    {
      $AP = 'AM'
    }

    $hourStr = $hour.ToString().PadLeft(2, '0')
    $retVal = "$($hourStr):$($minuteStr):$($secondStr) $AP"
  }
  else 
  {
    $hourStr = $hour.ToString().PadLeft(2, '0')
    $retVal = "$($hourStr):$($minuteStr):$($secondStr)"
  }

  Write-Verbose "$fn Fabricated Time: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}