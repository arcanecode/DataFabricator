<#
.SYNOPSIS
Fabricates a TaxpayerID (In the US this would be the Social Security Number), a taxpayer identification number..

.DESCRIPTION
Will generate a taxpayer ID Number (abbreviated TaxpayerID) for the specified CountryCode. 
If no CountryCode is passed in, the cmdlet defaults to the US social security number in xxx-xx-xxxx format.

.PARAMETER NoFormatting
Switch that will prevent formatting, such as dashes or spaces, from being included in the output.

.PARAMETER CountryCode
Enumerated country code. If no code is supplied it defaults to the US.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String with the fabricated TaxpayerID.

.EXAMPLE
Get-FabricatedTaxpayerID

Get-FabricatedTaxpayerID returns the following data:

TaxpayerID | 082-12-7296

.EXAMPLE
Get-FabricatedTaxpayerID -NoFormatting

Get-FabricatedTaxpayerID returns the following data (for the default CountryCode):

TaxpayerID | 082127296

.EXAMPLE
Get-FabricatedTaxpayerID -CountryCode UK

Get-FabricatedTaxpayerID returns the following data:

TaxpayerID | 01234 56789

.EXAMPLE
Get-FabricatedTaxpayerID -CountryCode UK -NoFormatting

Get-FabricatedTaxpayerID returns the following data:

TaxpayerID | 0123456789

.NOTES
Data Fabricator - Get-FabricatedTaxpayerID.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedTaxpayerID()
{
  [CmdletBinding()]
  param (
          [string] $CountryCode = 'US'
        , [switch] $NoFormatting
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         CountryCode: $CountryCode
         NoFormatting: $($NoFormatting.IsPresent)
"@

  #----------------------------------------------------------------------------------------------
  # Create some embedded helper functions
  #----------------------------------------------------------------------------------------------

  # US ------------------------------------------------------------------------------------------
  function usID ([bool] $noFormat)
  {
    # Calculate a TaxpayerID
    $first = (0..999  | Get-Random).ToString().PadLeft( 3, '0')
    $mid   = (0..99   | Get-Random).ToString().PadLeft( 2, '0')
    $last  = (0..9999 | Get-Random).ToString().PadLeft( 4, '0')
  
    if ( $noFormat )
      { $retVal = "$($first)$($mid)$($last)" }
    else
      { $retVal = "$first-$mid-$last" }

    return $retVal
 }

  # UK ------------------------------------------------------------------------------------------
  function ukID ([bool] $noFormat)
  {
    # Calculate a TaxpayerID
    $first = (0..99999 | Get-Random).ToString().PadLeft( 5, '0')
    $last  = (0..99999 | Get-Random).ToString().PadLeft( 5, '0')
  
    if ( $noFormat )
      { $retVal = "$($first)$($last)" }
    else
      { $retVal = "$first $last" }

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
    'UK'    { $retVal = ukID( $NoFormatting.IsPresent ) }
    'US'    { $retVal = usID( $NoFormatting.IsPresent ) }
    default { $retVal = usID( $NoFormatting.IsPresent ) }
  }
 
  Write-Verbose "$fn Fabricated TaxpayerID for $CountryCode is $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}