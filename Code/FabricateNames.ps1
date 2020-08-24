function Get-FabricatedFirstName()
{
  [CmdletBinding()]
  param ()
  
  $retVal = $m_NamesFirst | Get-Random

  return $retVal 
}

function Get-FabricatedLastName()
{
  [CmdletBinding()]
  param ()
  
  $retVal = $m_NamesLast | Get-Random

  return $retVal 
}

function Get-FabricatedFirstLastName()
{
  [CmdletBinding()]
  param ()
  
  $firstName = $m_NamesFirst | Get-Random
  $lastName = $m_NamesLast | Get-Random

  $retVal = "$firstName $lastName"

  return $retVal 
}

function Get-FabricatedLastFirstName()
{
  [CmdletBinding()]
  param ()
  
  $firstName = $m_NamesFirst | Get-Random
  $lastName = $m_NamesLast | Get-Random

  $retVal = "$lastName, $firstName"

  return $retVal 
}

function Get-FabricatedFirstMiLastName()
{
  [CmdletBinding()]
  param ()
  
  $firstName = $m_NamesFirst | Get-Random
  $mi = $m_Letter | Get-Random
  $lastName = $m_NamesLast | Get-Random

  $retVal = "$firstName $mi. $lastName"

  return $retVal 
}

function Get-FabricatedLastFirstMiName()
{
  [CmdletBinding()]
  param ()
  
  $firstName = $m_NamesFirst | Get-Random
  $mi = $m_Letter | Get-Random
  $lastName = $m_NamesLast | Get-Random

  $retVal = "$lastName, $firstName $mi."

  return $retVal 
}
