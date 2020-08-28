function Get-FabricatedTime()
{
  [CmdletBinding()]
  param (
          [switch] $AMPM
        )

  $hour = 0..23 | Get-Random
  $minute = 0..59 | Get-Random
  $second = 0..59 | Get-Random
  $AP = ''

  $minuteStr = $minute.ToString().PadLeft(2, '0')
  $secondStr = $second.ToString().PadLeft(2, '0')

  if ( $AMPM.IsPresent )
  {
    if ( $hour -ge 12 )
    {
      $hour = $hour - 12
      $AP = 'PM'
    }
    else 
    {
      $AP = 'AM'
    }

    $hourStr = $hour.ToString().PadLeft(2, '0')
    $retVal = "$($hourStr):$($minuteStr):$($secondStr) $AP"
  }
  else 
  {
    $hourStr = $hour.ToString().PadLeft(2, '0')
    $retVal = "$($hourStr):$($minuteStr):$($secondStr)"
  }

  return $retVal

}