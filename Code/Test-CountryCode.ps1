<#
.SYNOPSIS
Tests the country code to see if it is valid.

.DESCRIPTION
People suck at following directions. 
Even though we provided an easy way to return a list of valid country codes, the Get-CountryCodes cmdlet, we both know someone is going to try something bogus just to see if it works.
So we had to create this cmdlet, which tests the country code. If it is valid it returns true.
If not, it returns false and outputs a warning message about it being invalid.
In most cmdlets if the code is invalid it then uses the default code of US and continues processing.

.PARAMETER CountryCode
The country code being tested.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
The cmdlet returns either true or false

.EXAMPLE
Test-CountryCode -CountryCode 'US'

Test-CountryCode returns data similar to the following example:

True

.EXAMPLE
Test-CountryCode -CountryCode 'Mars'

Test-CountryCode returns data similar to the following example:

False

.NOTES
Data Fabricator - Test-CountryCode.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCity.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPhone.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedPostalCode.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedState.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedTaxpayerID.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-StateName.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCityStatePostalCodeRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCompanyRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedCustomerRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedEmployeeRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/Get-FabricatedInventoryRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Test-CountryCode()
{
  [CmdletBinding()]
  param (
          $CountryCode
        )

 # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Country Code: $CountryCode
"@

  if ( $m_CountryCode.Contains($CountryCode) )
  {
    $retVal = $true
  }
  else
  {
    Write-Error "$CountryCode is not a valid country code. Use Get-CountryCodes to get a valid list."  
    $retVal = $false
  }

  Write-Verbose "$fn - Testing $CountryCode returns $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}
