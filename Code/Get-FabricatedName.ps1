<#
.SYNOPSIS
Fabricates names, first and last, from internal lists of over 20,000 names.

.DESCRIPTION
In order to protect the innocent, we wouldn't want to use real names so this cmdlet will generate a fake name for you.

By default, this function will return a name in "First Last" format.
However, using the swticthes (documented below) you can change the output.

.PARAMETER First
Switch that will cause the function to only return a First name: First

.PARAMETER Last
Switch that will cause the function to only return a Last name: Last

.PARAMETER FirstMiLast
Switch to have the name returned with a middle initial: First M Last

.PARAMETER FirstMiddleLast
Switch that will include a middle name: First Middle Last

.PARAMETER LastFirst
Switch that returns the last name first: Last, First

.PARAMETER LastFirstMi
Switch that returns the last name at the beginning, with first name and middle initial following: Last, First M

.PARAMETER LastFirstMiddle
Switch that places the last name at the beginning, and includes the first and middle names: Last, First Middle

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String containing a fabricated name.

.EXAMPLE
Get-FabricatedName 

Get-FabricatedName returns data similar to the following example:

Name | John Sapien

.EXAMPLE
Get-FabricatedName -First

Get-FabricatedName returns data similar to the following example:

Name | Sherril

.EXAMPLE
Get-FabricatedName -Last

Get-FabricatedName returns data similar to the following example:

Name | Piercy

.EXAMPLE
Get-FabricatedName -FirstMiLast

Get-FabricatedName returns data similar to the following example:

Name | Gertie F. Phillip

.EXAMPLE
Get-FabricatedName -FirstMiddleLast

Get-FabricatedName returns data similar to the following example:

Name | Loyce Coral Caldwell

.EXAMPLE
Get-FabricatedName -LastFirst

Get-FabricatedName returns data similar to the following example:

Name | Wixom, Eli

.EXAMPLE
Get-FabricatedName -LastFirstMi

Get-FabricatedName returns data similar to the following example:

Name | Tunnell, Evan E.

.EXAMPLE
Get-FabricatedName -LastFirstMiddle

Get-FabricatedName returns data similar to the following example:

Name | Boothe, Janiyah Lou

.NOTES
Data Fabricator - Get-FabricatedName.ps1

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

function Get-FabricatedName()
{
  [CmdletBinding()]
  param (
          [switch] $First
        , [switch] $Last
        , [switch] $FirstMiLast
        , [switch] $FirstMiddleLast
        , [switch] $LastFirst
        , [switch] $LastFirstMi
        , [switch] $LastFirstMiddle
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  # Go ahead and generate some names, we'll use these to assemble the output
  $firstName = $m_NamesFirst | Get-Random
  $mi = $m_Letter | Get-Random
  $middleName = $m_NamesFirst | Get-Random
  $lastName = $m_NamesLast | Get-Random    

  switch ($true)
  {
    $First.IsPresent { $retVal = $firstName }

    $Last.IsPresent  { $retVal = $lastName }

    $FirstMiLast.IsPresent { $retVal = "$firstName $mi. $lastName" }

    $FirstMiddleLast.IsPresent { $retVal = "$firstName $middleName $lastName" }

    $LastFirst.IsPresent { $retVal = "$lastName, $firstName" }

    $LastFirstMi.IsPresent { $retVal = "$lastName, $firstName $mi." }

    $LastFirstMiddle.IsPresent { $retVal = "$lastName, $firstName $middleName" }

    default { $retVal = "$firstName $lastName" }
  }

  Write-Verbose "$fn Fabricated Name $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal 

}
