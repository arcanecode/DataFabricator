class CompanyRecord
{
  [string] $Name
  [string] $Address1
  [string] $Address2
  [string] $City
  [string] $State
  [string] $Zip
  [string] $ContactName
  [string] $ContactPhone
  [string] $ContactEMail
  [string] $ContactJobTitle
}
function New-FabricatedCompanyRecord()
{
  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
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
    # Fabricate city/state/zip and name records
    $csz = New-FabricatedCityStateZipCodeRecord -Verbose:$false
    $name = New-FabricatedNameRecord -Verbose:$false

    $company = [CompanyRecord]::new()
    $company.Name = Get-FabricatedCompany -Verbose:$false
    $company.Address1 = Get-FabricatedAddressLine1 -Verbose:$false
    $company.Address2 = Get-FabricatedAddressLine2 -Verbose:$false
    $company.City = $csz.City
    $company.State = $csz.State
    $company.Zip = $csz.ZipCode

    $company.ContactName = $name.FirstLast
    $email = $company.Name.ToLower().Replace(' ', '')
    $company.ContactEMail = "$($name.EmailName)@$($email).com"

    $company.ContactPhone = Get-FabricatedPhone -Verbose:$false
    $company.ContactJobTitle = Get-FabricatedJobTitle -Verbose:$false
    
    $item = $company.Name
    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"

    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $company; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.Name.Contains($company.Name) -eq $false)
      {        
        $retVal += $company; $i++   # If not there are are safe to add it
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
  $retVal = $retVal | Sort-Object -Property Name

  # Return our results
  return $retVal

}