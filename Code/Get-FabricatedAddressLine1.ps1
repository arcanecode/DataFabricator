function Get-FabricatedAddressLine1 {

  [CmdletBinding()]
  param ()

  $number = $(1..9999 | Get-Random).ToString()

  $first = $m_StreetsFirst | Get-Random
  $last = $m_StreetsLast | Get-Random

  $street = "$number $first $last"

  # 20 percent of the time, add a compass direction
  if ($(1..100 | Get-Random) -le 20)
  {
    # Note the space prior to the direction
    $compass = " $($m_Compass | Get-Random)"
  }
  else 
  {
    # If above 20% we won't add anything
    $compass = ''
  }

  # Note the need to embed variables in $() since we have one next to the other
  $retVal = "$($street)$($compass)"

  return $retval

}