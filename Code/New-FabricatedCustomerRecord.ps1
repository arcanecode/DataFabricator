function New-FabricatedCustomerRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [string] $EMailDomain = 'fakemail.com'
        , [string] $CountryCode = 'US'
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date

  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count: $RecordCount
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
         EMailDomain: $EMailDomain
"@

  # Create a class for our return object
  class CustomerRecord
  {
    [string] $FirstName
    [string] $MiddleName
    [string] $LastName
    [string] $FullName
    [string] $CustomerID
    [string] $EMail
    [string] $HomePhone
    [string] $MobilePhone
    [string] $WorkPhone
    [string] $HomeAddress1
    [string] $HomeAddress2
    [string] $HomeCity
    [string] $HomeState
    [string] $HomePostalCode
    [string] $WorkAddress1
    [string] $WorkAddress2
    [string] $WorkCity
    [string] $WorkState
    [string] $WorkPostalCode
    [string] $BirthDate
  }

  # If no code is passed in, or they use unspecified, use the US
  if ( ($null -eq $CountryCode) -or ( $CountryCode -eq 'Unspecified') )
    { $CountryCode = 'US' }

  # Warn if the country code is invalid, but continue working using the US instead
  if ( (Test-CountryCode -CountryCode $CountryCode) -eq $false )
    { Write-Warning "The country code $CountryCode is invalid, reverting to use US instead." }

  # Declare an empty array to hold the results
  $retVal = @()
  
  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  while ($i -lt $RecordCount) 
  {
    # Fabricate city/state/PostalCode and name records
    $cszHome = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $cszWork = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $name = New-FabricatedNameRecord -Verbose:$false

    $cust = [CustomerRecord]::new()

    $cust.FirstName = $name.First
    $cust.MiddleName = $name.Middle
    $cust.LastName = $name.Last
    $cust.FullName = $name.FirstMiddleLast

    $custnumber = $(1..999999 | Get-Random).ToString().PadLeft(6,'0')
    $cust.CustomerID = "$($cust.LastName.Substring(0, 2).ToUpper())$($custnumber)"

    $cust.EMail = "$($name.EmailName)@$($EMailDomain)"

    $cust.HomePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $cust.MobilePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $cust.WorkPhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false

    $cust.HomeAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $cust.HomeAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $cust.HomeCity = $cszHome.City
    $cust.HomeState = $cszHome.State
    $cust.HomePostalCode = $cszHome.PostalCode

    $cust.WorkAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $cust.WorkAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $cust.WorkCity = $cszWork.City
    $cust.WorkState = $cszWork.State
    $cust.WorkPostalCode = $cszWork.PostalCode

    $cust.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 -Verbose:$false
 
    $item = $cust.FullName
    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $cust; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.FullName.Contains($cust.FullName) -eq $false)
      {        
        $retVal += $cust; $i++   # If not there are are safe to add it
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

  # Sort the output before returning
  $retVal = $retVal | Sort-Object -Property LastName, FirstName, MiddleName

  # Return our results
  return $retVal

}