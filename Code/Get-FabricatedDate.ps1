<#
.SYNOPSIS
Fabricates a date and (optionally) a time.

.DESCRIPTION
This flexible cmdlet has the ability generate dates in either string or datetime format.
By default it will uses ranges in the last 50 years backwards from the current year, however these are easily overridden using the parameters (see each parameter for more information).
The default format for the returned string is YYYY-MM-DD (only a date, no time), unless overridden.
Using switches (see below) you can change the format a well as include a fabricated time.

.PARAMETER FromYear
The year to begin generating dates from. If no date is passed it, by default it will go back 50 years from the current year.

.PARAMETER ThruYear
The final year to use for date generation. If no year is supplied it will default to the current year.

.PARAMETER RelativeFromYear
Rather than hard coding a year, you can use this parameter to create an offset from the current year as the starting year.
For example, if you pass in 100, and the current year is 2020, the starting year will be 1920.
When New Years hits and we get to 2021, the starting year will become 2021.

.PARAMETER RelativeThruYear
Just like the RelativeFromYear, this parameter can be used to set a relative end year for date generation.
This can be especially useful for generating birthdays for employees.
Many companies require people to be a minimum age, for example 21.
Using 21 for a relative thru year would assure all dates fabricated would be at least 21 years ago.

.PARAMETER AsDateTime
Switch that will return the fabricated date as a datetime datatype instead of a string. 
Note if you do not also use the FabricatedTime switch, the default time will be midnight (12:00:00 AM).

.PARAMETER FormatMDY
Switch that will return the date in MM-DD-YYYY format instead of the default YYYY-MM-DD format.

.PARAMETER FormatDMY
Swtich that will return the date in DD-MM-YYYY format instead of the default YYYY-MM-DD format.

.PARAMETER FabricateTime
Switch that will fabricate a time of the day instead of using the default of midnight (12:00:00 AM).

.INPUTS
This cmdlet has no inputs.

.OUTPUTS
Either a string or a datetime datatype with a fabricated date.

.EXAMPLE
Get-FabricatedDate

Get-FabricatedDate returns the following string:

Date | 1991-12-23

.EXAMPLE
Get-FabricatedDate -FromYear 1930

Get-FabricatedDate returns the following string:

Date | 1936-02-27

.EXAMPLE
Get-FabricatedDate -FromYear 1000 -ThruYear 1200

Get-FabricatedDate returns the following string:

Date | 1042-02-27

.EXAMPLE
Get-FabricatedDate -RelativeFromYear 1000

Get-FabricatedDate returns the following string:

Date | 1764-05-21

.EXAMPLE
Get-FabricatedDate -RelativeThruYear 21

Get-FabricatedDate returns the following string:

Date | 1984-02-07

.EXAMPLE
Get-FabricatedDate -AsDateTime

Get-FabricatedDate returns the following datetime datatype:

Date | Tuesday, August 18, 1981 12:00:00 AM

.EXAMPLE
Get-FabricatedDate -AsDateTime -FabricateTime

Get-FabricatedDate returns the following datetime datatype:

Date | Tuesday, June 14, 2011 4:18:26 AM

.EXAMPLE
Get-FabricatedDate -FormatMDY

Get-FabricatedDate returns the following string:

Date | 10-28-1998

.EXAMPLE
Get-FabricatedDate -FormatDMY

Get-FabricatedDate returns the following string:

Date | 22-02-1975

.EXAMPLE
Get-FabricatedDate -FabricateTime

Get-FabricatedDate returns the following string:

Date | 1992-05-28 07:27:33

.NOTES
Data Fabricator - Get-FabricatedDate.ps1

Author: Robert C Cain | @ArcaneCode | arcane@arcanetc.com

This code is Copyright (c) 2020 Robert C Cain All rights reserved

The code herein is for demonstration purposes.
No warranty or guarantee is implied or expressly granted.

This module may not be reproduced in whole or in part without
the express written consent of the author.

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedCustomerRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedEmployeeRecord.md

.LINK
https://github.com/arcanecode/DataFabricator/blob/master/Documentation/New-FabricatedSalesRecord.md

.LINK
http://arcanecode.me

.LINK
http://datafabricator.com
#>

function Get-FabricatedDate()
{
  [CmdletBinding()]
  param (
          [int] $FromYear = -9999
        , [int] $ThruYear = -9999
        , [int] $RelativeFromYear = -9999
        , [int] $RelativeThruYear = -9999
        , [switch] $AsDateTime
        , [switch] $FormatMDY
        , [switch] $FormatDMY
        , [switch] $FabricateTime
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         FromYear $FromYear 
         ThruYear $ThruYear 
         RelativeFromYear $RelativeFromYear
         RelativeThruYear $RelativeThruYear
"@

  # If ThruYear is not overridden, set it to this year
  if ($ThruYear -eq -9999) { $endYear = $(Get-Date).Year }
  else                     { $endYear = $ThruYear }

  # If the from year is the default, subract 50 from the end year
  if ($FromYear -eq -9999) { $startYear = $endYear - 50 }
  else                     { $startYear = $FromYear }

  # A relative from overrides the from year. It subtracts the value from the thru year
  if ($RelativeFromYear -ne -9999)
  {
    $startYear = $endYear - $RelativeFromYear
  }

  # Sometimes you are generating birthdates, and for example might want
  # someone to be at least 21. You could pass in 21 in this value and it will
  # back up 21 years as the last possible date to generate
  if ($RelativeThruYear -ne -9999)
  {
    $endYear = $endYear - $RelativeThruYear
  }

  # Now we can calculate and get a random year
  $retYear = $startYear..$endYear | Get-Random

  # Get a random month
  $retMonth = (1..12 | Get-Random).ToString().PadLeft(2, '0')

  # Based on the month number calculate the date
  # Note, since this is fake data we're just going to ignore leap years
  switch ($retMonth)
  {
    ($_ -in (1,3,5,7,8,10,12)) 
      { $retDay = (1..31 | Get-Random).ToString().PadLeft(2, '0') }

    ($_ -in (4,6,9,11))        
      { $retDay = (1..30 | Get-Random).ToString().PadLeft(2, '0') }
    
    default                    
      { $retDay = (1..28 | Get-Random).ToString().PadLeft(2, '0') }
  }

  # Calculate a time, make sure to put a space in front of it

  # Create the return value
  if ($AsDateTime.IsPresent)
  {
    # If they want it as a DateTime, we need to add a time to the string to
    # make it convert to a DateTime correctly.
    # If user asked for it, fabricate a time, otherwise use 00:00:00
    if ($FabricateTime.IsPresent)  { $time = Get-FabricatedTime }
    else                           { $time = '00:00:00' }

    $retVal = [DateTime]"$retYear-$retMonth-$retDay $time"
  }
  else
  {
    # If they wanted time included, add it, otherwise make it blank
    if ($FabricateTime.IsPresent)  { $time = " $(Get-FabricatedTime)" }
    else                           { $time = '' }

    # If we are returning as a string, we can then determine the format
    switch ($true)
    {
      $FormatMDY.IsPresent { $retVal = "$retMonth-$retDay-$retYear$($time)" }
      $FormatDMY.IsPresent { $retVal = "$retDay-$retMonth-$retYear$($time)" }
      default              { $retVal = "$retYear-$retMonth-$retDay$($time)" }
    }
  }

  Write-Verbose "$fn Fabricated Date: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}