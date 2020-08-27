function Get-FabricatedCity()
{
  [CmdletBinding()]
  param ()

  $retVal = $m_Cities | Get-Random 

  return $retVal 

}