class City
{
  [string] $City
  [string] $State
}
function ConvertFrom-CityStateCode()
{ 
  [CmdletBinding()]
  param (
          [string] $CityStateCode
        )

  Write-Verbose "CityStateCode: $CityStateCode"

  $state = $CityStateCode.Substring(0, 2)
  Write-Verbose "State: $state"

  $code = $CityStateCode.Substring(2)
  Write-Verbose "Code: $code"

  $city = $m_CityCodes[$code]

  $retVal = [City]::new()

  $retVal.City = $city
  $retVal.State = $state

  return $retVal
  
}