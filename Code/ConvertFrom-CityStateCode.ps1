<#
.SYNOPSIS
Converts a CityState code back to a city and state

.DESCRIPTION
Takes a CityState code (the city code with the two character state abbreviation on front) and deconstructs it, converting it back to the city and state.

.PARAMETER CityStatecode
The code holding the state and city code

.INPUTS
This has no inputs

.OUTPUTS
An object array with two properties, the City and State.

.EXAMPLE
ConvertFrom-CityStateCode -CityStateCode "ALAARONSBURGCDP"

ConvertFrom-CityStateCode returns the following data:

City: Aaronsburg CDP

State: AL

.NOTES
Data Fabricator - ConvertFrom-CityStateCode

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/ConvertFrom-CityStateCode.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>
function ConvertFrom-CityStateCode()
{ 
  [CmdletBinding()]
  param (
          [Parameter( Mandatory = $true,
                      HelpMessage = 'Please enter a valid city state code.'
                    )
          ]          
          [string] $CityStateCode
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CityStateCode: $CityStateCode
"@

  # This is the class structure that the function will return
  class City
  {
    [string] $City
    [string] $State
  }
  
  #Extract the State abbreviation
  $state = $CityStateCode.Substring(0, 2)

  # Extract the City Code
  $code = $CityStateCode.Substring(2)
  
  # Get the city code based on the code from the hash table
  $city = $m_CityCodes[$code]

  # Create a new object to return
  $retVal = [City]::new()
  $retVal.City = $city
  $retVal.State = $state

  # Show what we found
  Write-Verbose "$fn City: $city State: $state"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}