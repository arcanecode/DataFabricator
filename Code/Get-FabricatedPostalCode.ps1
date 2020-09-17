<#
.SYNOPSIS
Fabrictes a postal code.

.DESCRIPTION
Real postal codes just lead to more junk mail, and who needs yet another high interest rate credit card offer?

This cmldet will generate a postal code in the format used by the country represented in the country code parameter. 
If no code is passed, it will default to a country code of US. 

In the US postal codes, known as Zip Codes, are five numbers indicating the area of mail service.
The US postal system also supports an additional four numbers known as the "Plus 4" system that provides additional accuracy.
By default, for US codes, this cmdlet will randomly generate a five digit zip code in 00000 format, using the switch it will append the additional plus 4 in 00000-0000 format.

Note that the fabricated postal codes are randomly generated, and may or may not actually exist.

.PARAMETER Plus4
Switch that will add a randomly generated plus 4 code to the returned zip code. Note that this parameter is only valid when the country code is US, for other country codes it will be ignored.

.PARAMETER PlusFour
Alias to the Plus4 switch.

.PARAMETER CountryCode
Country code. If no code is supplied it defaults to the US.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
A string with a generated postal code, matching the format for the country code used (US by defalt)

.EXAMPLE
Get-FabricatedPostalCode

Get-FabricatedPostalCode returns a string with the following data:

Postal Code | 12345

.EXAMPLE
Get-FabricatedPostalCode -Plus4

Get-FabricatedPostalCode returns a string with the following data:

Postal Code | 12345-6789

.EXAMPLE
Get-FabricatedPostalCode -PlusFour

Get-FabricatedPostalCode returns a string with the following data:

Postal Code | 12345-6789

.EXAMPLE
Get-FabricatedPostalCode -CountryCode UK

Get-FabricatedPostalCode returns a string with the following data:

Postal Code | MV6Y 2BH

.NOTES
Data Fabricator - Get-FabricatedPostalCode.ps1

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

function Get-FabricatedPostalCode {

  [CmdletBinding()]
  param (
          [string] $CountryCode = 'US'
        , [Alias('PlusFour')]
          [switch] $Plus4
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CountryCode..: $CountryCode
         Plus4........: $($Plus4.IsPresent)
"@


  #----------------------------------------------------------------------------------------------
  # Create some embedded helper functions
  #----------------------------------------------------------------------------------------------

  # US ------------------------------------------------------------------------------------------
  function usPostal ( [bool] $plus4 )
  {
    $first = $(1..99999 | Get-Random).ToString().PadLeft(5, '0')
  
    if ($plus4)
      { $last = "-$($(1..9999 | Get-Random).ToString().PadLeft(4, '0'))" }
    else
      { $last = '' }

    $retVal = "$($first)$($last)"

    return $retVal
 }

  # UK ------------------------------------------------------------------------------------------
  function ukPostal ( [bool] $plus4 )
  {
    # The UK has several variations on the postal code format. For this project we will go with
    # a common simple format of AA9A 9AA

    if ( $plus4 )
      { Write-Verbose "$fn - The use of Plus4 is invalid with CountryCodes other than US and will be ignored." } 

    $l1 = $m_TwoLetter | Get-Random
    $l2 = (0..9 | Get-Random).ToString()
    $l3 = $m_Letter | Get-Random
    $l4 = (0..9 | Get-Random).ToString()
    $l5 = $m_TwoLetter | Get-Random

    $retVal = "$l1$l2$l3 $l4$l5" 

    return $retVal
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

  switch ( $CountryCode )
  {
    'UK'    { $retVal = ukPostal( $Plus4.IsPresent ) }
    'US'    { $retVal = usPostal( $Plus4.IsPresent ) }
    default { $retVal = usPostal( $Plus4.IsPresent ) }
  }

  Write-Verbose "$fn Fabricated Postal Code: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}