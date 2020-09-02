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
        , [Alias('PlusFour')]
          [switch] $Plus4
        )

  $retVal = @()

  Write-Verbose "Record Count $RecordCount"

  for ($i = 0; $i -lt $RecordCount; $i++)
  {
    Write-Verbose "Generating record $i"

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

    Write-Verbose "CSZ: $($csz.City) $($csz.State) $($csz.ZipCode)"
    $retVal += $csz
  }

  return $retVal

}