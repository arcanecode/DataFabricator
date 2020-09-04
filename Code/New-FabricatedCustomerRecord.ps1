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
  [string] $HomeZip
  [string] $WorkAddress1
  [string] $WorkAddress2
  [string] $WorkCity
  [string] $WorkState
  [string] $WorkZip
  [string] $BirthDate
}
function New-FabricatedCustomerRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [string] $EMailDomain = 'fakemail.com'
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

  # Declare an empty array to hold the results
  $retVal = @()
  
  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  while ($i -lt $RecordCount) 
  {
    $cust = [CustomerRecord]::new()

    $cust.FirstName = Get-FabricatedName -First -Verbose:$false
    $cust.MiddleName = Get-FabricatedName -First -Verbose:$false
    $cust.LastName = Get-FabricatedName -Last -Verbose:$false
    $cust.FullName = "$($cust.FirstName) $($cust.MiddleName) $($cust.LastName)"

    $custnumber = $(1..999999 | Get-Random).ToString().PadLeft(6,'0')
    $cust.CustomerID = "$($cust.LastName.Substring(0, 2).ToUpper())$($custnumber)"

    $cust.EMail = "$($cust.FirstName.Substring(0, 1).ToLower()).$($cust.LastName.ToLower())@$($EMailDomain)"

    $cust.HomePhone = Get-FabricatedPhone -Verbose:$false
    $cust.MobilePhone = Get-FabricatedPhone -Verbose:$false
    $cust.WorkPhone = Get-FabricatedPhone -Verbose:$false

    $cust.HomeAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $cust.HomeAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $cust.HomeCity = Get-FabricatedCity -Verbose:$false
    $cust.HomeState = Get-FabricatedState -Verbose:$false
    $cust.HomeZip = Get-FabricatedZipCode -Verbose:$false

    $cust.WorkAddress1 = Get-FabricatedAddressLine1 -Verbose:$false
    $cust.WorkAddress2 = Get-FabricatedAddressLine2 -Verbose:$false
    $cust.WorkCity = Get-FabricatedCity -Verbose:$false
    $cust.WorkState = Get-FabricatedState -Verbose:$false
    $cust.WorkZip = Get-FabricatedZipCode -Verbose:$false

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