<#
.SYNOPSIS
Shows a text message with a listing of all the functions in the module, along with their synopsis.

.DESCRIPTION
Shows a text message with a listing of all the functions in the module, along with their synopsis. Included is a link to the online documentaiton.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
The cmdlet creates an array of one or more objects with the following properties

.EXAMPLE
Show-DataFabricatorFunctions

Show-DataFabricatorFunctions returns a rather large string with a list of all the functions in the DataFabricator, along with a synopsis of their use.

.NOTES
Data Fabricator - Show-DataFabricatorFunctions.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Show-DataFabricatorFunctions.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Show-DataFabricatorFunctions()
{
  [CmdletBinding()]
  param (
        )

  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  return $m_aboutFunctions

}
