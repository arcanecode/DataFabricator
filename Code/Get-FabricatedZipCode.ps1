<#
.SYNOPSIS
Fabrictes a US Zip Code in either 5 digit (the default) or the 5 Plus 4 format.

.DESCRIPTION
In the US postal codes, known as Zip Codes, are five numbers indicating the area of mail service.
The postal system also supports an additional four numbers known as the "Plus 4" system that provides additional accuracy.
By default this cmdlet will randomly generate a five digit zip code in 00000 format, using the switch it will append the additional plus 4 in 00000-0000 format.
Note that these zip codes are randomly generated, and may or may not actually exist.

.PARAMETER Plus4
Switch that will add a randomly generated plus 4 code to the returned zip code.

.PARAMETER PlusFour
Alias to the Plus4 switch.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
A string with the five digit zip code in 00000 format, or 00000-0000 if the Plus4 switch is used.

.EXAMPLE
Get-FabricatedZipCode

Get-FabricatedZipCode returns a string with the following data:

12345

.EXAMPLE
Get-FabricatedZipCode -Plus4

Get-FabricatedZipCode returns a string with the following data:

12345-6789

.EXAMPLE
Get-FabricatedZipCode -PlusFour

Get-FabricatedZipCode returns a string with the following data:

12345-6789

.NOTES
Data Fabricator - Get-FabricatedZipCode.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCityStateZipRecord.md

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

function Get-FabricatedZipCode {

  [CmdletBinding()]
  param (
          [Alias('PlusFour')]
          [switch] $Plus4
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Get a random number for the first part
  $first = $(1..99999 | Get-Random).ToString().PadLeft(5, '0')

  if ($Plus4.IsPresent)
  {
    $last = "-$($(1..9999 | Get-Random).ToString().PadLeft(4, '0'))"
  }
  else
  {
    $last = ''
  }

  $retVal = "$($first)$($last)"

  Write-Verbose "$fn Fabricated Zip Code: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}