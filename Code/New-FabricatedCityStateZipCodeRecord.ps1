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

  $retVal = @()

  Write-Verbose "Record Count $RecordCount"
  
  $dupeTrackingCount = 0
  $i = 0
  
  while ($i -lt $RecordCount)
  {
    $csz = [CityStateZipCode]::new()
  
    $csz.City = Get-FabricatedCity
    $csz.State = Get-FabricatedState    
    $csz.StateName = $m_StateTable[$csz.State]
  
    if ($Plus4.IsPresent) 
    {
      $csz.ZipCode = Get-FabricatedZipCode -Plus4
    }
    else 
    {
      $csz.ZipCode = Get-FabricatedZipCode
    }
  
    $csz.CityStZipCode = "$($csz.City), $($csz.State) $($csz.ZipCode)"
    $csz.CityStateZipCode = "$($csz.City), $($csz.StateName) $($csz.ZipCode)"
    $csz.CityCode = "$($csz.State)$(ConvertTo-CityCode -City $csz.City)"

    Write-Verbose "Record #$($i): $($csz.City) $($csz.State) $($csz.ZipCode)"
    
    # Firse we need to make sure we have at least one record
    # Then, if this code is not already in the array, then increment
    # the record count and add it to the output array
    if ($retVal.Count -gt 0)
    {
      if ($retVal.CityCode.Contains($csz.CityCode) -eq $false)
      {
        $i++
        $retVal += $csz
      }
      else
      {
        $dupeTrackingCount++
        Write-Verbose "Dupe Alert #$($dupeTrackingCount) Skipping: $($csz.City) $($csz.State) $($csz.ZipCode)"
      }
    }
    else # This is the first record so add it
    {
      $i++
      $retVal += $csz
    }

    if ( $dupeTrackingCount -ge $MaxDuplicateCountBeforeError )
    {
      $i = $RecordCount + 1
      $err = @"
      Duplicate Max Count Exceeded, $dupeTrackingCount duplicates were generated. 
      You may have tried to create more records than the number of possible combinations.
      Suggestion: Try running again with a lower value for the RecordCount parameter.
      Alternatively, increase the value of the MaxDuplicateCountBeforeError to a number greater than $MaxDuplicateCountBeforeError
"@
      Write-Error $err
    }
  }

  return $retVal

}