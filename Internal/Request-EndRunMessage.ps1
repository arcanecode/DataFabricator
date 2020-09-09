<#
.SYNOPSIS
This is an INTERNAL ONLY function that the cmdlets use to create an "end of run" message for use in write-verbose statements.

.DESCRIPTION
In order to provide metrics each cmdlet creates a start and end time for run. Users can see this info using the Write-Verbose cmdlet.
This function takes the start and end times and calculates the run time, formatting it to display in milliseconds, seconds, or minutes.
It then bundles that into a nicely formatted readable message letting a user know the cmdlet is done processing.

I chose to put this in a cmdlet of it's own because it is used in just about all the other cmdlets here. 
It let me keep the coding in them minimal, and it gives me one place to go should I want to update the message.

.PARAMETER FunctionName
The name of the function (cmdlet) this is being executed from.

.PARAMETER StartTime
The time the calling function began

.PARAMETER EndTime
The time the function ended (or at least the time right before it ends)

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Returns a string that looks like everything that follows the VERBOSE:

Note we indent the ending and elapsed lines so they line up under the function name

VERBOSE: FunctionName
         Ending at... time
         Elapsed Time... nn seconds

.EXAMPLE
$start = Get-Date
# do some stuff
$end = Get-Date
Request-EndRunMessage -FunctionName 'Set-OnMyButt' -StartTime $start -EndTime $end

Request-EndRunMessage returns data similar to the following example, note the first line will be indetned by the VERBOSE tag in the output:

Set-OnMyButt
         Ending at 2020-09-09 01:25:52 PM
         Elapsed Time 0.2022 Milliseconds

.NOTES
Data Fabricator - Request-EndRunMessage.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Request-EndRunMessage()
{
  [CmdletBinding()]
  param (
            [string] $FunctionName
        , [datetime] $StartTime
        , [datetime] $EndTime
        )

  $rt = $EndTime - $StartTime  # Run Time

  # Format the output time
  if ($rt.TotalSeconds -lt 1)
    { $elapsed = "$($rt.TotalMilliseconds.ToString('#,0.0000')) Milliseconds" }
  elseif ($rt.TotalSeconds -gt 60)
    { $elapsed = "$($rt.TotalMinutes.ToString('#,0.0000')) Minutes" }
  else
    { $elapsed = "$($rt.TotalSeconds.ToString('#,0.0000')) Seconds" }

  # Create the return string
  # Note the spacing is deliberate, so the output will be:
  # VERBOSE: FunctionName
  #          Ending at...
  #          Elapsed Time....
  $endRunInfo = @"
$FunctionName
         Ending at $($EndTime.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Elapsed Time $elapsed
"@

  return $endRunInfo

}
