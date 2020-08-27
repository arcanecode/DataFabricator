function Get-FabricatedZipCode {

  [CmdletBinding()]
  param (
          [Alias('PlusFour')]
          [switch] $Plus4
        )

  # Get a random number for the first part
  $first = $(1..99999 | Get-Random).ToString().PadLeft(5, '0')

  if ($Plus4.IsPresent)
  {
    $last = "-$($(1..9999 | Get-Random).ToString().PadLeft(4, '0'))"
  }
  else
  {
    $last = ''
  }

  $retVal = "$($first)$($last)"

  return $retVal

}