<#
.SYNOPSIS
Fabricate one or more records with city, state, and zip code data.

.DESCRIPTION
This cmdlet will genereate an object (or array of them) with combinations of randomly selected cities, states and zip codes.
Because these are randomly selected, you will wind up with odd results sometimes, such as placing Salt Lake City in Alabama, with a zip code somewhere in Michigan.
That's not only acceptable but desired, as this data is only supposed to be realistic looking, not actually real.
One additional field is the CityCode. 
This is the city run through the ConvertTo-CityCode cmdlet, and will produce a unique value (based on the data supplied with the module) that is suitable for use as a key.
This value is appended to the two letter state abbreviation to produce unqiue city/state keys.

.PARAMETER RecordCount
The number of records you want returned from this cmdlet. The default is 1.

.PARAMETER MaxDuplicateCountBeforeError
This cmdlet checks for duplicates so they are removed from the final output.
By default, once the cmdlet has generated 50 duplicates it will throw an error and exit before all the records have been generated (although it will return what it has generated to that point).
It is possible in some cases to request more records than it is possible to create based on the internal data.
To keep from falling into an infinite loop this mechanism will exit and let the user know what the issue is.
Normally you won't need to override this, but it is possible should you feel the need.

.PARAMETER Plus4
Switch that will add a randomly generated plus 4 code to the returned zip code.
(See the documentation for Get-FabricatedZipCode for more info on plus 4 codes.)

.PARAMETER PlusFour
Alias to the Plus4 switch.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Object (or array of objects) with the following properties.

City | A randomly selected city.
State | A randomly selected two character state code.
StateName | The full name of the state for the corresponding state code.
ZipCode | Randomly generated zip code.
CityStZipCode | Full city, state abbreviation, and zip combined in a string, i.e. "Chelsea, AL 12345".
CityStateZipCode | City, full state name, and zip combined in a string, i.e. "Chelsea, Alabama 12345".
CityCode | The city which has been processed using the ConvertTo-CityCode cmdlet. Allows the city to be used as a unique key.

.EXAMPLE
New-FabricatedCityStateZipCodeRecord | Test-Pipe

New-FabricatedCityStateZipCodeRecord returns the following data.

City | Chinook CDP
State | AK
StateName | Alaska
ZipCode | 27264
CityStZipCode | Chinook CDP, AK 27264
CityStateZipCode | Chinook CDP, Alaska 27264
CityCode | AKCHINOOKCDP

.EXAMPLE
New-FabricatedCityStateZipCodeRecord -RecordCount 5 | Test-Pipe

New-FabricatedCityStateZipCodeRecord returns 5 records with data similar to the previous example.

.EXAMPLE
New-FabricatedCityStateZipCodeRecord -Plus4 | Test-Pipe

New-FabricatedCityStateZipCodeRecord returns the following data:

City | Chinook CDP
State | AK
StateName | Alaska
ZipCode | 27264
CityStZipCode | Chinook CDP, AK 27264-3982
CityStateZipCode | Chinook CDP, Alaska 27264-3982
CityCode | AKCHINOOKCDP

.NOTES
Data Fabricator - New-FabricatedCityStateZipCodeRecord.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCity.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedState.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedZipCode.md

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

function New-FabricatedCityStateZipCodeRecord {

  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [Alias('PlusFour')]
          [switch] $Plus4
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count: $RecordCount
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
         Plus4 Switch Used: $($Plus4.IsPresent)
"@

  # Declare the class that will be used for the return CityStateZipCode objects
  class CityStateZipCode
  {
    [string] $City
    [string] $State 
    [string] $StateName 
    [string] $ZipCode
    [string] $CityStZipCode
    [string] $CityStateZipCode
    [string] $CityCode
  }

  # Declare an empty array to hold the CityStateZipCode objects
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount)
  {
    $csz = [CityStateZipCode]::new()
  
    $csz.City = Get-FabricatedCity -Verbose:$false
    $csz.State = Get-FabricatedState -Verbose:$false
    $csz.StateName = $m_StateTable[$csz.State]
  
    if ($Plus4.IsPresent) 
      { $csz.ZipCode = Get-FabricatedZipCode -Plus4 -Verbose:$false }
    else 
      { $csz.ZipCode = Get-FabricatedZipCode -Verbose:$false }
  
    $csz.CityStZipCode = "$($csz.City), $($csz.State) $($csz.ZipCode)"
    $csz.CityStateZipCode = "$($csz.City), $($csz.StateName) $($csz.ZipCode)"
    $csz.CityCode = "$($csz.State)$(ConvertTo-CityCode -City $csz.City -Verbose:$false)"

    # Format a string with the item key for informational usage
    $spCity = ' ' * ($c_MaxCitiesLength - $csz.City.Length)
    $item = "$($csz.City)$spCity $($csz.State) $($csz.ZipCode)"

    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"
    
    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $csz; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.CityCode.Contains($csz.CityCode) -eq $false)
      {        
        $retVal += $csz; $i++   # If not there are are safe to add it
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
  }

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Sort the output
  $retVal = $retVal | Sort-Object -Property CityCode

  # Return our results
  return $retVal

}