function Get-FabricatedCityStateZipCode {

  [CmdletBinding()]
  param (
          [Alias('PlusFour')]
          [switch] $Plus4
        , [switch] $FullStateName
        )

  $city = Get-FabricatedCity

  if ($FullStateName.IsPresent)
  {
    $st = Get-FabricatedState -FullName
  }
  else 
  {
    $st = Get-FabricatedState    
  }

  if ($Plus4.IsPresent) 
  {
    $zip = Get-FabricatedZipCode -Plus4
  }
  else 
  {
    $zip = Get-FabricatedZipCode
  }

  $retVal = "$city, $st $zip"

  return $retVal

}