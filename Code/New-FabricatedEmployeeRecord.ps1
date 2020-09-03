class EmployeeRecord
{
  [string] $FirstName
  [string] $MiddleName
  [string] $LastName
  [string] $FullName
  [string] $SSN
  [string] $EmployeeID
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

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount) 
  {
    $emp = [EmployeeRecord]::new()

    $emp.FirstName = Get-FabricatedName -First
    $emp.MiddleName = Get-FabricatedName -First
    $emp.LastName = Get-FabricatedName -Last
    $emp.FullName = "$($emp.FirstName) $($emp.MiddleName) $($emp.LastName)"

    $emp.SSN = Get-FabricatedSSN
    $emp.EmployeeID = "$($emp.LastName.Substring(0, 2).ToUpper())$($emp.SSN.Substring($emp.SSN.Length - 4, 4)) "

    $emp.EMail = "$($emp.FirstName.Substring(0, 1).ToLower()).$($emp.LastName.ToLower())@$($EMailDomain)"

    $emp.HomePhone = Get-FabricatedPhone
    $emp.MobilePhone = Get-FabricatedPhone
    $emp.WorkPhone = Get-FabricatedPhone

    $emp.HomeAddress1 = Get-FabricatedAddressLine1
    $emp.HomeAddress2 = Get-FabricatedAddressLine2
    $emp.HomeCity = Get-FabricatedCity
    $emp.HomeState = Get-FabricatedState
    $emp.HomeZip = Get-FabricatedZipCode

    $emp.WorkAddress1 = Get-FabricatedAddressLine1
    $emp.WorkAddress2 = Get-FabricatedAddressLine2
    $emp.WorkCity = Get-FabricatedCity
    $emp.WorkState = Get-FabricatedState
    $emp.WorkZip = Get-FabricatedZipCode

    $emp.BirthDate = Get-FabricatedDate -RelativeThruYear 18 -RelativeFromYear 70 
    $emp.HireDate = Get-FabricatedDate -RelativeFromYear 15

    $emp.JobTitle = Get-FabricatedJobTitle

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