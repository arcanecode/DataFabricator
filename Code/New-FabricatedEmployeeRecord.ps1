class EmployeeRecord
{
  [string] $FirstName
  [string] $MiddleName
  [string] $LastName
  [string] $FullName
  [string] $TaxpayerID
  [string] $EmployeeID
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
  [string] $HireDate
  [string] $JobTitle
}
function New-FabricatedEmployeeRecord()
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
"@

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
  
  # Fabricate new rows
  while ($i -lt $RecordCount) 
  {
    # Fabricate city/state/zip and name records
    $cszHome = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $cszWork = New-FabricatedCityStatePostalCodeRecord -CountryCode $CountryCode -Verbose:$false
    $name = New-FabricatedNameRecord -Verbose:$false

    $emp = [EmployeeRecord]::new()

    $emp.FirstName = $name.First
    $emp.MiddleName = $name.Middle
    $emp.LastName = $name.Last
    $emp.FullName = $name.FirstMiddleLast

    $emp.TaxpayerID = Get-FabricatedTaxpayerID -CountryCode $CountryCode -Verbose:$false
    $emp.EmployeeID = "$($emp.LastName.Substring(0, 2).ToUpper())$($emp.TaxpayerID.Substring($emp.TaxpayerID.Length - 4, 4)) "

    $emp.EMail = "$($name.EmailName)@$($EMailDomain)"

    $emp.HomePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $emp.MobilePhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false
    $emp.WorkPhone = Get-FabricatedPhone -CountryCode $CountryCode -Verbose:$false

    $emp.HomeAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $emp.HomeAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $emp.HomeCity = $cszHome.City
    $emp.HomeState = $cszHome.State
    $emp.HomePostalCode = $cszHome.PostalCode

    # It's fairly common for work address to have a line 2, so we'll use a high threshold
    $emp.WorkAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $emp.WorkAddress2 = Get-FabricatedAddressLine2 -Threshold 75 -Verbose:$false
    $emp.WorkCity = $cszWork.City
    $emp.WorkState = $cszWork.State
    $emp.WorkPostalCode = $cszWork.PostalCode

    $emp.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 -Verbose:$false
    $emp.HireDate = Get-FabricatedDate -RelativeFromYear 15 -Verbose:$false

    $emp.JobTitle = Get-FabricatedJobTitle -Verbose:$false

    $item = $emp.FullName
    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $emp; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.FullName.Contains($emp.FullName) -eq $false)
      {        
        $retVal += $emp; $i++   # If not there are are safe to add it
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