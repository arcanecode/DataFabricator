function Get-FabricatedTime()
{
  [CmdletBinding()]
  param (
          [switch] $AMPM
        )

  # Function Name
  $fn = "$($PSCmdlet.MyInvocation.MyCommand.Module) - $($PSCmdlet.MyInvocation.MyCommand.Name)"
  $st = Get-Date
  Write-Verbose @"
$fn
         Starting at $($st.ToString('yyyy-MM-dd hh:mm:ss tt'))
"@

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

  Write-Verbose "$fn Fabricated Time: $retVal"

  # Let user know we're done 
  $et = Get-Date   # End Time
  Request-EndRunMessage -FunctionName $fn -StartTime $st -EndTime $et | Write-Verbose 

  # Return our results
  return $retVal

}