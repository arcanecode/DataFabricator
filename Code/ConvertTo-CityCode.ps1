function ConvertTo-CityCode()
{
  [CmdletBinding()]
  param (
          [string] $City
        )

  $retVal = $City.Replace(' ', '').Replace('-', '').Replace(',', '').Replace("'", '').Replace('.', '').ToUpper()

  return $retVal
  
}