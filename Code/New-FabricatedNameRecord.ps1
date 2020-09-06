<#
.SYNOPSIS
Fabricates a name record complete with all variations

.DESCRIPTION
Where Get-FabricatedName returns a variation with a name based on a switch, this cmdlet will return all variations of a name in one concise record.

.PARAMETER RecordCount
The number of records you want returned from this cmdlet. The default is 1.

.PARAMETER MaxDuplicateCountBeforeError
This cmdlet checks for duplicates so they are removed from the final output.
By default, once the cmdlet has generated 50 duplicates it will throw an error and exit before all the records have been generated (although it will return what it has generated to that point).
It is possible in some cases to request more records than it is possible to create based on the internal data.
To keep from falling into an infinite loop this mechanism will exit and let the user know what the issue is.
Normally you won't need to override this, but it is possible should you feel the need.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Array of objects with the following properties:

First - The first name

Middle - Middle Name

MiddleInitial - First letter of the middle name

Last - Last Name

FirstLast - The full name in the format "John Doe"

FirstMiLast - First and last with middle initial, "John X. Doe"

FirstMiddleLast - First, middle and last name, "John Xavier Doe"

LastFirst - Name in reverse format, "Doe, John"

LastFirstMi - Name in reverse format ending with the middle initial, "Doe, John X."

LastFirstMiddle - Name in reverse format with the full middle name, "Doe, John Xavier"

EmailName - The name suitible for the opening part of an email address, "j.doe"

NameCode - This is the name converted to uppercase with underscores, useful for a key. "DOE_JOHN_XAVIER"

.EXAMPLE
New-FabricatedNameRecord

New-FabricatedNameRecord returns an object with the following data:

First: Eliana
Middle: Corey
MiddleInitial: C
Last: Moore
FirstLast: Eliana Moore
FirstMiLast: Eliana C. Moore
FirstMiddleLast: Eliana Corey Moore
LastFirst: Moore, Eliana
LastFirstMi: Moore, Eliana C.
LastFirstMiddle: Moore, Eliana Corey
EmailName: e.moore
NameCode: MOORE_ELIANA_COREY

.EXAMPLE
New-FabricatedNameRecord -RecordCount 5

New-FabricatedNameRecord returns 5 records with output similar to the previous example.

.NOTES
Data Fabricator - New-FabricatedNameRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedName.md

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

function New-FabricatedNameRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

  class NameRecord
  {
    [string] $First
    [string] $Middle
    [string] $MiddleInitial
    [string] $Last
    [string] $FirstLast
    [string] $FirstMiLast
    [string] $FirstMiddleLast
    [string] $LastFirst
    [string] $LastFirstMi
    [string] $LastFirstMiddle
    [string] $EmailName
    [string] $NameCode
  }

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount)
  {
    # Generate some names, we'll use these to assemble the output
    $firstName = $m_NamesFirst | Get-Random
    $middleName = $m_NamesFirst | Get-Random
    $mi = $middleName.Substring(0, 1)
    $lastName = $m_NamesLast | Get-Random    

    $n = [NameRecord]::new()

    $n.First = $firstName
    $n.Middle = $middleName
    $n.MiddleInitial = $mi
    $n.Last = $lastName
    $n.FirstLast = "$firstName $lastName"
    $n.FirstMiLast = "$firstName $mi. $lastName"
    $n.FirstMiddleLast = "$firstName $middleName $lastName"
    $n.LastFirst = "$lastName, $firstName"
    $n.LastFirstMi = "$lastName, $firstName $mi."
    $n.LastFirstMiddle = "$lastName, $firstName $middleName"
    $n.EmailName = "$($firstName.Substring(0, 1).ToLower()).$($lastName.ToLower())"
    $n.NameCode = "$($lastName.ToUpper())_$($firstName.ToUpper())_$($middleName.ToUpper())"

    $item = "$($n.FirstMiddleLast) $($n.EmailName) $($n.NameCode)"

    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $n; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.NameCode.Contains($n.NameCode) -eq $false)
      {        
        $retVal += $n; $i++   # If not there are are safe to add it
      }
      else
      {
        $dupeTrackingCount++    # Mark as a dupe
        Write-Verbose "$fn - Duplicate   #$($dupeTrackingCount.ToString('#,##0')): $item Skipping"
      }
    }

    # If we exceeded the max dupe error count, error out
    if ( $dupeTrackingCount -ge $MaxDuplicateCountBeforeError )
    {
      $i = $RecordCount + 1     # Set it high so the while loop will exit
      Request-DupeErrorMessage -FunctionName $fn -DuplicateCount $dupeTrackingCount | Write-Verbose
    }

  } # while ($i -lt $RecordCount)

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal 


}
