class CityStateZipCode
{
  [string] $City
  [string] $State 
  [string] $StateName 
  [string] $ZipCode
  [string] $CityStZipCode
  [string] $CityStateZipCode
  [string] $CityCode
}
function New-FabricatedCityStateZipCodeRecord {

  [CmdletBinding()]
  param (
          [int] $RecordCount = 1
        , [int] $MaxDuplicateCountBeforeError = 50  
        , [Alias('PlusFour')]
          [switch] $Plus4
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Record Count: $RecordCount
         Max Duplicate Rows Befor Error: $MaxDuplicateCountBeforeError
         Plus4 Switch Used: $($Plus4.IsPresent)
"@

  # Declare an empty array to hold the results
  $retVal = @()

  # Set the counters
  $dupeTrackingCount = 0
  $i = 0
  
  # Fabricate new rows
  while ($i -lt $RecordCount)
  {
    $csz = [CityStateZipCode]::new()
  
    $csz.City = Get-FabricatedCity
    $csz.State = Get-FabricatedState    
    $csz.StateName = $m_StateTable[$csz.State]
  
    if ($Plus4.IsPresent) 
      { $csz.ZipCode = Get-FabricatedZipCode -Plus4 }
    else 
      { $csz.ZipCode = Get-FabricatedZipCode }
  
    $csz.CityStZipCode = "$($csz.City), $($csz.State) $($csz.ZipCode)"
    $csz.CityStateZipCode = "$($csz.City), $($csz.StateName) $($csz.ZipCode)"
    $csz.CityCode = "$($csz.State)$(ConvertTo-CityCode -City $csz.City)"

    # Format a string with the item key for informational usage
    $spCity = ' ' * ($c_MaxCitiesLength - $csz.City.Length)
    $item = "$($csz.City)$spCity $($csz.State) $($csz.ZipCode)"

    Write-Verbose "$fn - Fabricating #$($i.ToString('#,##0')): $item"
    
    # If no values we need to add the first one. If we don't, the dupe check below will
    # error out on a null valued array ($retVal)
    if ( $retVal.Count -eq 0 )
    {
      $retVal += $csz; $i++
    }   
    else
    {
      # Now do the dupe check
      if ($retVal.CityCode.Contains($csz.CityCode) -eq $false)
      {        
        $retVal += $csz; $i++   # If not there are are safe to add it
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

  # Sort the output
  $retVal = $retVal | Sort-Object -Property CityCode

  # Return our results
  return $retVal

}