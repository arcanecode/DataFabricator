function Get-FabricatedName()
{
  [CmdletBinding()]
  param (
          [switch] $First
        , [switch] $Last
        , [switch] $FirstMiLast
        , [switch] $FirstMiddleLast
        , [switch] $LastFirst
        , [switch] $LastFirstMi
        , [switch] $LastFirstMiddle
        )

  # Go ahead and generate some names, we'll use these to assemble the output
  $firstName = $m_NamesFirst | Get-Random
  $mi = $m_Letter | Get-Random
  $middleName = $m_NamesFirst | Get-Random
  $lastName = $m_NamesLast | Get-Random    

  switch ($true)
  {
    $First.IsPresent { $retVal = $firstName }

    $Last.IsPresent  { $retVal = $lastName }

    $FirstMiLast.IsPresent { $retVal = "$firstName $mi. $lastName" }

    $FirstMiddleLast.IsPresent { $retVal = "$firstName $middleName $lastName" }

    $LastFirst.IsPresent { $retVal = "$lastName, $firstName" }

    $LastFirstMi.IsPresent { $retVal = "$lastName, $firstName $mi." }

    $LastFirstMiddle.IsPresent { $retVal = "$lastName, $firstName $middleName" }

    default { $retVal = "$firstName $lastName" }
  }

  return $retVal 

}
