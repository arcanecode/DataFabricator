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

.PARAMETER CountryCode
Country code. If no code is supplied it defaults to the US.

.PARAMETER RecordCount
The number of records you want returned from this cmdlet. The default is 1.

.PARAMETER MaxDuplicateCountBeforeError
This cmdlet checks for duplicates so they are removed from the final output.
By default, once the cmdlet has generated 50 duplicates it will throw an error and exit before all the records have been generated (although it will return what it has generated to that point).
It is possible in some cases to request more records than it is possible to create based on the internal data.
To keep from falling into an infinite loop this mechanism will exit and let the user know what the issue is.
Normally you won't need to override this, but it is possible should you feel the need.

.PARAMETER Plus4
Switch that will add a randomly generated plus 4 code to the returned zip code. If a CountryCode other than US is used, this switch is ignored.
(See the documentation for Get-FabricatedPostalCode for more info on plus 4 codes.)

.PARAMETER PlusFour
Alias to the Plus4 switch.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Object (or array of objects) with the following properties.

City                | A randomly selected city
State               | A randomly selected two character state code
StateName           | The full name of the state for the corresponding state code
PostalCode          | Randomly generated zip code
CityStPostalCode    | Full city, state abbreviation, and zip combined in a string, i.e. "Chelsea, AL 12345"
CityStatePostalCode | City, full state name, and zip combined in a string, i.e. "Chelsea, Alabama 12345"
CityCode            | The city which has been processed using the ConvertTo-CityCode cmdlet. Allows the city to be used as a unique key

.EXAMPLE
New-FabricatedCityStatePostalCodeRecord

New-FabricatedCityStatePostalCodeRecord returns the following data.

City                | Chinook CDP
State               | AK
StateName           | Alaska
PostalCode          | 27264
CityStPostalCode    | Chinook CDP, AK 27264
CityStatePostalCode | Chinook CDP, Alaska 27264
CityCode            | AKCHINOOKCDP

.EXAMPLE
New-FabricatedCityStatePostalCodeRecord -RecordCount 5

New-FabricatedCityStatePostalCodeRecord returns 5 records with data similar to the previous example.

.EXAMPLE
New-FabricatedCityStatePostalCodeRecord -Plus4

New-FabricatedCityStatePostalCodeRecord returns the following data:

City                | Chinook CDP
State               | AK
StateName           | Alaska
PostalCode          | 27264
CityStPostalCode    | Chinook CDP, AK 27264-3982
CityStatePostalCode | Chinook CDP, Alaska 27264-3982
CityCode            | AKCHINOOKCDP

.EXAMPLE
New-FabricatedCityStatePostalCodeRecord -CountryCode UK

New-FabricatedCityStatePostalCodeRecord returns the following data:

City                | St Davids
State               | WE
StateName           | Westmorland
PostalCode          | QH6Z 9RX
CityStPostalCode    | St Davids, WE QH6Z 9RX
CityStatePostalCode | St Davids, Westmorland QH6Z 9RX
CityCode            | WESTDAVIDS

.EXAMPLE
New-FabricatedCityStatePostalCodeRecord -CountryCode UK -RecordCount 5

New-FabricatedCityStatePostalCodeRecord returns 5 records with data similar to the previous example.

.NOTES
Data Fabricator - New-FabricatedCityStatePostalCodeRecord.ps1

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
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPostalCode.md

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

function New-FabricatedCityStatePostalCodeRecord {

  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [string] $CountryCode = 'US'
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
         CountryCode: $CountryCode
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
         Plus4 Switch Used: $($Plus4.IsPresent)
"@

  # Declare the class that will be used for the return CityStatePostalCode objects
  class CityStatePostalCode
  {
    [string] $City
    [string] $State 
    [string] $StateName 
    [string] $PostalCode
    [string] $CityStPostalCode
    [string] $CityStatePostalCode
    [string] $CityCode
  }

  #----------------------------------------------------------------------------------------------
  #  Main logic to create and return the ID
  #----------------------------------------------------------------------------------------------

  # If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  # Declare an empty array to hold the CityStatePostalCode objects
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount)
  {
    $csp = [CityStatePostalCode]::new()
  
    $csp.City = Get-FabricatedCity -CountryCode $CountryCode -Verbose:$false
    $csp.State = Get-FabricatedState -CountryCode $CountryCode -Verbose:$false
    $csp.StateName = Get-StateName -StateAbbr $csp.State -CountryCode $CountryCode -Verbose:$false
  
    if ($Plus4.IsPresent) 
      { $csp.PostalCode = Get-FabricatedPostalCode -CountryCode $CountryCode -Plus4 -Verbose:$false }
    else 
      { $csp.PostalCode = Get-FabricatedPostalCode -CountryCode $CountryCode -Verbose:$false }
  
    $csp.CityStPostalCode = "$($csp.City), $($csp.State) $($csp.PostalCode)"
    $csp.CityStatePostalCode = "$($csp.City), $($csp.StateName) $($csp.PostalCode)"
    $csp.CityCode = "$($csp.State)$(ConvertTo-CityCode -City $csp.City -Verbose:$false)"

    # Format a string with the item key for informational usage
    switch ( $CountryCode )
    {
      'UK'    { $spCity = ' ' * ($c_MaxCitiesUKLength - $csp.City.Length)}
      'US'    { $spCity = ' ' * ($c_MaxCitiesUSLength - $csp.City.Length) }
      default { $spCity = ' ' * ($c_MaxCitiesUSLength - $csp.City.Length) }
    }

    $item = "$($csp.City)$spCity $($csp.State) $($csp.PostalCode)"

    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"
    
    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $csp; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.CityCode.Contains($csp.CityCode) -eq $false)
      {        
        $retVal += $csp; $i++   # If not there are are safe to add it
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