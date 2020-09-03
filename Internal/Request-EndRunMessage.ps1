function Request-EndRunMessage()
{
  [CmdletBinding()]
  param (
          [string] $FunctionName
        , [datetime] $StartTime
        , [datetime] $EndTime
        )

  $rt = $EndTime - $StartTime  # Run Time

  # Format the output time
  if ($rt.TotalSeconds -lt 1)
    { $elapsed = "$($rt.TotalMilliseconds.ToString('#,0.0000')) Milliseconds" }
  elseif ($rt.TotalSeconds -gt 60)
    { $elapsed = "$($rt.TotalMinutes.ToString('#,0.0000')) Minutes" }
  else
    { $elapsed = "$($rt.TotalSeconds.ToString('#,0.0000')) Seconds" }

  # Create the return string
  # Note the spacing is deliberate, so the output will be:
  # VERBOSE: FunctionName
  #          Ending at...
  #          Elapsed Time....
  $endRunInfo = @"
$FunctionName
         Ending at $($et.ToString('yyyy-MM-dd hh:mm:ss tt'))
         Elapsed Time $elapsed
"@

  return $endRunInfo

}
