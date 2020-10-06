<#
.SYNOPSIS
Fabricates an address typically used as the address line 1 in an address.

.DESCRIPTION
Most people don't want to give out their addresses, heck even the help authors don't want you know where we live for fear you'll come throw eggs at our house.
So we created this cmdlet, which will fabricate fake addresses.

Note that addresses often consist of two lines, address 1 and address 2. This will create a realistic but fake address suitable for address 1.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with an address

.EXAMPLE
Get-FabricatedAddressLine1

Get-FabricatedAddressLine1 returns data similar to the following example:

Address1 | 4964 Mackenzie Road

.NOTES
Data Fabricator - Get-FabricatedAddressLine1.ps1

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

function Get-FabricatedAddressLine1 {

  [CmdletBinding()]
  param ()

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  $number = $(1..9999 | Get-Random).ToString()

  $first = $m_StreetsFirst | Get-Random
  $last = $m_StreetsLast | Get-Random

  $street = "$number $first $last"

  # 20 percent of the time, add a compass direction
  if ($(1..100 | Get-Random) -le 20)
  {
    # Note the space prior to the direction
    $compass = " $($m_Compass | Get-Random)"
  }
  else 
  {
    # If above 20% we won't add anything
    $compass = ''
  }

  # Note the need to embed variables in $() since we have one next to the other
  $retVal = "$($street)$($compass)"

  Write-Verbose "$fn $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retval

}