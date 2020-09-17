<#
.SYNOPSIS
Fabricates a phone number for the CountryCode, defaulting to the US based format.

.DESCRIPTION
We wouldn't want to use real phone numbers, telemarters are horrible! They always seem to call at meal time.

This cmdlet generates random numbers to compose a phone number for the CountryCode parameter, to avoid those meal interrupting calls.
If no CountryCode is passed in, it will default to the US format of xxx-xxx-xxxx.
To suppress extra charcters like dashes, spaces, and so on from the phone number use the NoFormatting switch.

.PARAMETER NoFormatting
Switch that will prevent formatting, such as dashes or spaces, from being included in the output.

.PARAMETER CountryCode
Enumerated country code. If no code is supplied it defaults to the US.

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
String containing the fabricated phone number.

.EXAMPLE
Get-FabricatedPhone

Get-FabricatedPhone returns data similar to the following example:

Phone | 672-344-1425

.EXAMPLE
Get-FabricatedPhone -NoDashes

Get-FabricatedPhone returns data similar to the following example:

Phone | 6723441425

.EXAMPLE
Get-FabricatedPhone -UK

Get-FabricatedPhone returns data similar to the following example:

Phone | (029) 6723 1425

.EXAMPLE
Get-FabricatedPhone -UK -NoFormatting

Get-FabricatedPhone returns data similar to the following example:

Phone | 02967231425

.NOTES
Data Fabricator - Get-FabricatedPhone.ps1

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

function Get-FabricatedPhone()
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
  function usPhone ([bool] $noFormat)
  {

    # (US Phones don't start with 0)
    $first = (100..999 | Get-Random).ToString().PadLeft( 3, '0')
    $mid   = (0..999   | Get-Random).ToString().PadLeft( 3, '0')
    $last  = (0..9999  | Get-Random).ToString().PadLeft( 4, '0')
  
    if ( $noFormat )
      { $retVal = "$($first)$($mid)$($last)" }
    else
      { $retVal = "$first-$mid-$last" }

    return $retVal
 }

  # UK ------------------------------------------------------------------------------------------
  function ukPhone ([bool] $noFormat)
  {
    # The UK has a rather complicated phone number system. For simplicity, we'll limit the
    # output to two areas. London, because it's the biggest city, and Cardiff, because that's
    # where a lot of Doctor Who is filmed.
    # (020) nnnn nnnn London
    # (029) nnnn nnnn Cardiff

    # Calculate the phone number
    $first = (0..9999 | Get-Random).ToString().PadLeft( 4, '0')
    $last  = (0..9999 | Get-Random).ToString().PadLeft( 4, '0')
  
    if ( $noFormat )
    { 
      $ukPrefix = ('020', '029') | Get-Random
      $retVal = "$($ukPrefix)$($first)$($last)" 
    }
    else
    { 
      $ukPrefix = ('(020)', '(029)') | Get-Random
      $retVal = "$ukPrefix $first $last" 
    }

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
    'UK'    { $retVal = ukPhone( $NoFormatting.IsPresent ) }
    'US'    { $retVal = usPhone( $NoFormatting.IsPresent ) }
    default { $retVal = usPhone( $NoFormatting.IsPresent ) }
  }

  Write-Verbose "$fn Fabricated Phone $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
 # Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal
  
}