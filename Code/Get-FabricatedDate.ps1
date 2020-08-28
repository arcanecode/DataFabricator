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

  return $retVal

}