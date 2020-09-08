function Test-CountryCode()
{
  [CmdletBinding()]
  param (
          $CountryCode
        )

  if ( $m_CountryCode.Contains($CountryCode) )
  {
    $retVal = $true
  }
  else
  {
    Write-Error "$CountryCode is not a valid country code. Use Get-CountryCodes to get a valid list."  
    $retVal = $false
  }

  return $retVal

}
