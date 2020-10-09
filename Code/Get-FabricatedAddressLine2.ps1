<#
.SYNOPSIS
Fabricates an address suitable for the second line in an address, such as an apartment number or office suite.

.DESCRIPTION
Often, but not always, an address will contain a second line that will be an apartment number or office suite. After all, how is the package delivery person supposed to know which location to leave your mutilated, crushed and water soaked package at?

To account for the fact that an address2 line is not always used, this function calculates a percentage of the time to generate an address 2, by default 25%.

This means there is a 25% chance of returning an address2, the rest of the time it will return an empty value for address2. Note this is calculated on each call to the function, it is not done across calls.

The default threshold can be overridden using the Threshold parameter. Since it is more common for a business to have a second address line, the
cmdlets in this module that deal with work / company addresses use a much higher threshold.

.PARAMETER Threshold
The percentage of the time to return a value for address2, by default it is set to 25. To always return an address2 line, set the threshold to 100.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with a realistic address2 line

.EXAMPLE
Get-FabricatedAddressLine2

Get-FabricatedAddressLine2 can return data that looks something like:

Address2 | Office 33

.EXAMPLE
Get-FabricatedAddressLine2 -Threshold 50

Get-FabricatedAddressLine2 will have a 50% chance of returning data, such as:

Address2 | Suite A

.EXAMPLE
Get-FabricatedAddressLine2 -Threshold 100

Get-FabricatedAddressLine2 will always return an address2 value, such as:

Address2 | Apartment 42

.NOTES
Data Fabricator - Get-FabricatedAddressLine2.ps1

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

function Get-FabricatedAddressLine2 ()
{
  [CmdletBinding()]
  param(
         [int] $Threshold = 25
       )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Threshold: $Threshold
"@

  # Do a little boundary checking
  if ($Threshold -lt 1) { $Threshold = 1 }
  if ($Threshold -gt 100) { $Threshold = 100 }

  # A majority of the time, the Address Line 2 is empty
  # The threshold is the percent of the time it will return a value
  $thresholdPercent = 1..100 | Get-Random

  if ($thresholdPercent -gt $Threshold)
  {
    $retVal = ''
    Write-Verbose "$fn Generated Threshold of $thresholdPercent%, which was above the maximum of $Threshold% so the address suppressed."
  }
  else
  {
    $first = $m_Address2First | Get-Random

    # 20 percent of the time, use a letter, otherwise use a number
    if ($(1..100 | Get-Random) -gt 20)
    {
      $last = $(1..9999 | Get-Random).ToString()
    }
    else
    {
      $last = $m_Letter | Get-Random
    }

    $retVal = "$first $last"
    Write-Verbose "$fn $retVal"
  }

  # Let user know we're done
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose

  # Return our results
  return $retVal

}