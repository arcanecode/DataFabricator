<#
.SYNOPSIS
Fabricates a location in a warehouse, referred to as a Bin number.

.DESCRIPTION
Many warehouses (like the condom factory I used to work at, no kidding for real!) follow a typical physical layout to indicate where a product is stored.

First is one to two letters, indicating what row a product can be found on. Each row contains racks with bins for storing products, typically on pallets.

Bins often use three numbers, the first number indicating a level (1, 2, or 3) like a floor in a building.

The second two indicate how far down the row to go, for example 33 being the 33rd bin.

This routine follows this pattern, creating two letters for a row and three numbers for the location on the row.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String holding a bin number in the format AA123

.EXAMPLE
Get-FabricatedBin

Get-FabricatedBin returns data similar to the following example:

Bin | IW328

.NOTES
Data Fabricator - Get-FabricatedBin.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedInventoryRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedBin()
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

  # Typically with warehouses, the first two letters indicate the row
  $l2 = $m_TwoLetter | Get-Random

  # The first number indicates the level of the bin, i.3. 1 is the bottom
  # row, 2 second, and 3 third
  # The last two numbers indicate how far down the row to go
  $num = (1..399 | Get-Random).ToString().PadLeft(3, '0')

  $retVal = "$l2$num"
  Write-Verbose "$fn Fabricated Bin: $retVal"

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  # Return our results
  return $retVal

}