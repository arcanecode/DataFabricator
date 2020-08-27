function Get-FabricatedState()
{
  [CmdletBinding()]
  param (
          [switch] $FullName
        )

  if ($FullName.IsPresent)
  {
    $retVal = $m_StateName | Get-Random
  }
  else 
  {
    $retVal = $m_StateAbbr | Get-Random  
  }

  return $retVal

}