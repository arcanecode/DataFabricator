function Get-FabricatedSSN()
{
  [CmdletBinding()]
  param (
          [switch] $NoDashes
        )

  $first = (0..999  | Get-Random).ToString().PadLeft( 3, '0')
  $mid   = (0..99   | Get-Random).ToString().PadLeft( 2, '0')
  $last  = (0..9999 | Get-Random).ToString().PadLeft( 4, '0')

  if ( $NoDashes.IsPresent )
  {
    $retVal = "$($first)$($mid)$($last)"
  }
  else
  {
    $retVal = "$first-$mid-$last"
  }

  return $retVal
  
}